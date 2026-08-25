# Visión general

## Problema

macOS no trae una app oficial de Google Calendar. La app nativa Calendar.app de Apple puede agregar cuentas de Google por CalDAV, pero no se ve ni se siente como Google Calendar, y no maneja Google Tasks ni Microsoft To Do de forma unificada.

## Objetivo (v1)

Una app nativa de macOS que:

1. Se ve y se siente muy parecida a Google Calendar (colores, vistas de mes/semana/día, barra lateral con lista de calendarios).
2. Sincroniza **varias cuentas de Google** (Calendar + Tasks) a la vez.
3. Sincroniza **cuentas de Microsoft** (Outlook Calendar + Microsoft To Do).
4. Muestra todo en una sola vista unificada, con eventos y tareas de todas las cuentas mezclados y diferenciados por color.
5. Permite crear, editar y eliminar eventos y tareas (no solo lectura).
6. Consume muy poca batería y CPU — requisito crítico explícito, no negociable.

## Fuera de alcance (v1)

- Apps para iPhone/iPad/Windows (solo macOS por ahora).
- Videollamadas integradas (Google Meet / Teams).
- Colaboración en tiempo real / edición simultánea con otras personas.
- Notificaciones push instantáneas al segundo (la sincronización es por polling inteligente, ver [ARCHITECTURE.md](ARCHITECTURE.md); puede haber unos minutos de retraso).
- Publicación en la Mac App Store (se evaluará más adelante si tiene sentido).

## Usuarios

Uso personal (una sola persona, varias cuentas propias), no un producto multiusuario.
