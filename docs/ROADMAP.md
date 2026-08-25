# Roadmap

Cada fase deja algo que se puede correr y probar, para ir viendo avance real.

## Fase 0 — Setup
- Crear proyecto Xcode con la configuración definida en [OPEN_QUESTIONS.md](OPEN_QUESTIONS.md) (macOS mínimo, bundle id, firma).
- Estructura de carpetas base (ver [ARCHITECTURE.md](ARCHITECTURE.md)).
- Guía paso a paso para crear las credenciales de Google Cloud y Azure.

## Fase 1 — Auth + lectura básica (Google, una cuenta)
- Login con una cuenta de Google.
- Traer y mostrar eventos del calendario principal en una lista simple (sin diseño final todavía).

## Fase 2 — Vista de calendario estilo Google Calendar
- Vistas de mes / semana / día.
- Paleta de colores y tipografía inspiradas en Google Calendar.
- Barra lateral con mini-calendario y lista de calendarios visibles/ocultos.

## Fase 3 — Multi-cuenta Google + Google Tasks
- Agregar/quitar varias cuentas de Google.
- Traer y mostrar Google Tasks junto a los eventos.

## Fase 4 — Integración Microsoft
- Login Microsoft (Azure app registration).
- Outlook Calendar + Microsoft To Do en la misma vista unificada.

## Fase 5 — Escritura (crear / editar / eliminar)
- Crear y editar eventos y tareas desde la app, reflejado de vuelta en Google/Microsoft.
- Eliminar eventos/tareas.

## Fase 6 — Sync en background + optimización de batería
- Implementar `NSBackgroundActivityScheduler` y delta sync.
- Perfilar con Instruments y ajustar hasta cumplir los objetivos de [BATTERY_PERFORMANCE.md](BATTERY_PERFORMANCE.md).

## Fase 7 (opcional) — Apple Calendar / Recordatorios
- Integrar EventKit para sumar iCloud a la vista unificada.

## Fase 8 — Pulido
- Paridad visual fina con Google Calendar (colores exactos, spacing, iconografía propia sin copiar assets con derechos de Google).
- Notificaciones locales opcionales.
- Atajos de teclado.

No hay fechas fijas — se avanza fase por fase, sin apuro, como pediste.
