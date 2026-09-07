# Guía: crear el proyecto de Google Cloud

Esto lo tienes que hacer tú (requiere tu cuenta de Google), pero es rápido y gratis. Los pasos 1 a 4 los puedes hacer ya, cuando quieras, no bloquean nada más. El paso 5 (crear el Client ID real) lo dejamos para la Fase 1, cuando ya tengamos el bundle id definitivo de la app.

## 1. Crear el proyecto

1. Entra a [console.cloud.google.com](https://console.cloud.google.com/) con la cuenta de Google que quieras usar como principal (las demás cuentas se agregan después, dentro de la app).
2. Arriba a la izquierda, en el selector de proyecto, click en **"Proyecto nuevo"**.
3. Nombre libre, por ejemplo `Calendario Unificado`. Crear.

## 2. Habilitar las APIs

1. Con el proyecto nuevo seleccionado, ve a **"APIs y servicios" → "Biblioteca"**.
2. Busca `Google Calendar API` y click en **"Habilitar"**.
3. Busca `Tasks API` y click en **"Habilitar"**.

## 3. Pantalla de consentimiento OAuth

1. Ve a **"APIs y servicios" → "Pantalla de consentimiento OAuth"**.
2. Tipo de usuario: **"Externo"** (para uso personal está bien, no hace falta cuenta de Google Workspace).
3. Completa nombre de la app, tu correo como correo de soporte, y tu correo como contacto del desarrollador. Guardar.
4. **No hace falta enviarla a verificación de Google** — para uso personal se queda en modo "Testing" sin problema.
5. En la sección **"Usuarios de prueba"**, agrega ahí cada cuenta de Gmail que vayas a conectar en la app (incluida la principal).

## 4. (Ya con esto, avísame)

Con los pasos 1 a 3 hechos, la app va a poder pedir permiso a esas cuentas de prueba. Avísame cuando lo tengas listo y seguimos con el paso 5 en la Fase 1.

## 5. Crear el Client ID (Fase 1, lo hacemos juntos)

1. Ve a **"APIs y servicios" → "Credenciales" → "Crear credenciales" → "ID de cliente de OAuth"**.
2. Tipo de aplicación: **"iOS"** (Google no tiene una categoría específica para apps nativas de macOS con SwiftUI; el tipo "iOS", basado en bundle id y sin client secret, es el que se usa también para apps de macOS que hacen login con `ASWebAuthenticationSession`).
3. Bundle ID: el que definamos para el proyecto Xcode (ver [OPEN_QUESTIONS.md](../OPEN_QUESTIONS.md), punto 5, todavía pendiente).
4. Copia el **Client ID** que te genera — eso es lo único que necesito de ti para esta parte, no hay client secret que guardar.
