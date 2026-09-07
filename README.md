# Calendario Unificado para macOS

App nativa de macOS (Swift + SwiftUI) que reemplaza la falta de una app oficial de Google Calendar en Mac: unifica múltiples cuentas de Google (Calendar + Tasks) y de Microsoft (Outlook Calendar + To Do) en una sola interfaz visualmente muy similar a Google Calendar, con consumo de batería/CPU muy bajo como requisito no negociable.

Estado actual: Fase 2 — vistas de día/semana/mes funcionando con fechas reales y navegación. Todavía sin cuentas conectadas ni sincronización.

## Cómo correrlo

1. Abre `UnifiedCalendar.xcodeproj` con Xcode (doble click).
2. Dale Run (⌘R).

No requiere cuenta de Apple Developer ni Apple ID: el proyecto usa firma ad-hoc (`CODE_SIGN_IDENTITY = "-"`), que en macOS deja correr la app en tu propio Mac indefinidamente.

## Cómo vamos a trabajar

Yo (Claude) escribo este código desde un contenedor Linux, sin Xcode ni un Mac disponible. Para no depender de que tú seas mi compilador, cada push se compila con `swift build` en un runner de macOS de GitHub Actions (ver `.github/workflows/build.yml`) y yo leo los errores de ahí.

Lo que CI no puede juzgar es cómo se *ve* la app. Para eso sí te necesito: abrirla en Xcode y decirme qué ajustar (colores, espaciados, proporciones).

## Documentación

- [docs/OVERVIEW.md](docs/OVERVIEW.md) — objetivo, alcance y fuera de alcance
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — stack técnico y estrategia de sincronización
- [docs/INTEGRATIONS.md](docs/INTEGRATIONS.md) — Google Calendar/Tasks API, Microsoft Graph, EventKit
- [docs/BATTERY_PERFORMANCE.md](docs/BATTERY_PERFORMANCE.md) — reglas de diseño para bajo consumo
- [docs/ROADMAP.md](docs/ROADMAP.md) — fases de desarrollo
- [docs/OPEN_QUESTIONS.md](docs/OPEN_QUESTIONS.md) — decisiones e información pendientes del usuario
- [docs/guides/GOOGLE_CLOUD_SETUP.md](docs/guides/GOOGLE_CLOUD_SETUP.md) — guía paso a paso para las credenciales de Google
