# Batería y rendimiento

Requisito explícito y no negociable del proyecto: la app tiene que ser muy liviana. Reglas de diseño que se siguen en todo el proyecto para lograrlo:

1. **Nada de Electron ni WebView embebida.** SwiftUI nativo. Un motor de navegador embebido corriendo en background es, con diferencia, la causa más común de que una app "liviana en apariencia" termine gastando muchísima batería.
2. **Sin polling agresivo.** Sincronización por *delta* (`syncToken` de Google, `delta query` de Microsoft), nunca "traer todo de nuevo cada X segundos".
3. **Sin timers de alta frecuencia en el hilo principal para tareas de red.** La sincronización en background usa `NSBackgroundActivityScheduler` con prioridad baja (`.utility`) e intervalos largos, dejando que el sistema decida el mejor momento (compatible con App Nap) en vez de forzar despertares constantes de CPU/radio.
4. **Pausa automática** de toda sincronización sin red, o con el Mac en Modo de Bajo Consumo (`ProcessInfo.processInfo.isLowPowerModeEnabled`).
5. **Listas y grillas con renderizado perezoso** (`LazyVStack`/`List` de SwiftUI), evitando recalcular toda la vista de calendario en cada actualización menor.
6. **Sin daemon/Login Item** corriendo indefinidamente salvo que el usuario lo pida explícitamente (por ejemplo, para notificaciones con la app cerrada).
7. **Medición obligatoria antes de cada entrega**: perfilar con Xcode Instruments (Energy Log y Time Profiler) para confirmar consumo de CPU/batería real, no solo "se ve bien a ojo". Esto es directamente por la mala experiencia previa que mencionaste — se verifica con datos, no se asume.

## Objetivo numérico de referencia

- CPU en reposo (app abierta, sin interacción): idealmente <1% promedio.
- RAM: uso moderado, sin crecer indefinidamente en sesiones largas (se revisa con Instruments que no haya memory leaks).
- Red: sin actividad fuera de las ventanas de sync programadas.

Estos números se validan con Instruments en la fase de optimización del roadmap (ver [ROADMAP.md](ROADMAP.md)), no son solo una aspiración.
