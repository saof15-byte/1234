# Integraciones

## Google (Calendar + Tasks)

- **APIs**: Google Calendar API v3 y Google Tasks API v1.
- **Auth**: OAuth 2.0 con PKCE, flujo de "app instalada" (Desktop), vía `ASWebAuthenticationSession`. Soporta múltiples cuentas: cada cuenta agregada guarda su propio token en Keychain.
- **Qué necesitas hacer tú** (no lo puedo hacer yo por ti, requiere tu cuenta de Google):
  1. Crear un proyecto en [Google Cloud Console](https://console.cloud.google.com/).
  2. Habilitar "Google Calendar API" y "Tasks API" para ese proyecto.
  3. Configurar la pantalla de consentimiento OAuth (puede quedar en modo "Testing/Externo sin publicar" — para uso personal no hace falta que Google la verifique).
  4. Crear una credencial OAuth de tipo "Desktop app" o "iOS" (con el bundle id de la app) y obtener el **Client ID**.
  - Te doy la guía paso a paso con capturas cuando lleguemos a esta fase (ver [ROADMAP.md](ROADMAP.md)).

## Microsoft (Outlook Calendar + Microsoft To Do)

- **API**: Microsoft Graph API (un solo API cubre Outlook Calendar y Microsoft To Do).
- **Auth**: registro de app en [portal.azure.com](https://portal.azure.com) → "App registrations" (gratis, no requiere una suscripción paga; una cuenta Microsoft personal alcanza). Permisos delegados necesarios: `Calendars.ReadWrite`, `Tasks.ReadWrite`.
- Librería: MSAL (Microsoft Authentication Library) para Swift/Objective-C, o flujo OAuth manual con `ASWebAuthenticationSession` igual que con Google.

## Apple Calendar / Recordatorios (iCloud) — opcional, bajo costo de implementación

- Vía **EventKit**, el framework nativo del sistema. No requiere OAuth ni credenciales propias: usa la sesión de iCloud que el Mac ya tiene configurada.
- Se puede sumar con relativamente poco esfuerzo extra para tener *todo* unificado (Google + Microsoft + Apple) en la misma vista. Ver pregunta en [OPEN_QUESTIONS.md](OPEN_QUESTIONS.md).

## Resumen de credenciales que vas a necesitar reunir

| Proveedor | Qué se necesita | Costo |
|---|---|---|
| Google | Client ID de OAuth (Google Cloud Console) | Gratis |
| Microsoft | App registration (Azure) | Gratis |
| Apple (iCloud) | Nada, usa EventKit | Gratis |
| Apple (firma/distribución) | Ver [OPEN_QUESTIONS.md](OPEN_QUESTIONS.md) | Gratis o 99 USD/año según la opción elegida |
