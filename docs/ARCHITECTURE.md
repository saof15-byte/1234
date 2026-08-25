# Arquitectura

## Stack

- **Swift + SwiftUI**, nativo de macOS. Nada de Electron ni WebView embebida: un motor de navegador dentro de la app es la primera causa de consumo alto de RAM/CPU/batería, y va directamente en contra del requisito de "app muy liviana".
- Patrón **MVVM**.
- macOS mínimo soportado: por definir (ver [OPEN_QUESTIONS.md](OPEN_QUESTIONS.md)) — afecta qué APIs de SwiftUI/SwiftData podemos usar.

## Persistencia local

- **SwiftData** (o Core Data si el macOS mínimo lo requiere) como caché local de eventos y tareas.
- La UI siempre lee de la base local, nunca espera una respuesta de red para pintar la pantalla → la app se siente instantánea y no depende de tener internet.
- La sincronización con Google/Microsoft actualiza la base local en segundo plano; la UI se refresca cuando hay cambios.

## Estrategia de sincronización (clave para batería)

- **Delta sync, no sync completo repetido**: Google Calendar API expone `syncToken` y Microsoft Graph expone `delta query` — se usan para traer *solo lo que cambió* desde la última sincronización, en vez de volver a descargar todos los eventos cada vez.
- **Sin polling agresivo ni conexiones abiertas permanentes** (nada de long-polling/websockets encendidos todo el tiempo, eso mantiene el radio de red activo y es una de las causas más comunes de gasto de batería en apps mal diseñadas).
- Dos velocidades de sincronización:
  - **App en primer plano/visible**: sync cada pocos minutos (configurable).
  - **App en segundo plano/minimizada**: sync con `NSBackgroundActivityScheduler` (`qualityOfService = .utility`), intervalos largos (15–30 min), dejando que macOS decida el momento óptimo (compatible con App Nap) en vez de forzar un timer propio de alta frecuencia.
- La sincronización se **pausa** automáticamente si no hay red o si el Mac está en Modo de Bajo Consumo (`ProcessInfo.processInfo.isLowPowerModeEnabled`).
- Sin daemon ni Login Item corriendo en background salvo que el usuario lo pida explícitamente (por ejemplo, para notificaciones incluso con la app cerrada).

## Autenticación

- Tokens OAuth guardados en **Keychain**, nunca en texto plano.
- Login mediante `ASWebAuthenticationSession` (abre el navegador del sistema para el login de Google/Microsoft, la app nunca ve ni maneja la contraseña).

## Estructura de módulos (propuesta inicial)

```
App/
  Models/          -> Event, Task, CalendarAccount (SwiftData)
  Sync/            -> GoogleSyncEngine, MicrosoftSyncEngine, SyncScheduler
  Auth/            -> GoogleAuthService, MicrosoftAuthService, KeychainStore
  UI/
    CalendarView/  -> vistas de mes/semana/día
    Sidebar/       -> lista de cuentas y calendarios
    EventEditor/   -> crear/editar evento o tarea
  Design/          -> paleta de colores y tipografía inspirada en Google Calendar
```

Ver [INTEGRATIONS.md](INTEGRATIONS.md) para el detalle de cada proveedor y [BATTERY_PERFORMANCE.md](BATTERY_PERFORMANCE.md) para las reglas de bajo consumo.
