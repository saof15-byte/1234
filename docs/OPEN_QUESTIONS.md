# Preguntas abiertas

Decisiones e información que necesito de ti antes de arrancar con código (Fase 0). Te las hago también como pregunta directa en la conversación; este archivo queda como registro de las respuestas.

## 1. Firma y distribución de la app

¿La app es solo para correr en tu Mac (build local desde Xcode con tu Apple ID gratuito, sin costo) o ya tienes/vas a sacar una cuenta de Apple Developer Program (99 USD/año)? Con cuenta gratuita hay que volver a firmar la app cada 7 días (una molestia menor); con cuenta paga se firma/notariza sin ese límite y queda abierta la puerta a distribuir un `.dmg` o incluso Mac App Store más adelante.

**Respuesta:** Build local gratis con Xcode. Sin cuenta de Developer Program por ahora.

## 2. Versión mínima de macOS a soportar

¿Qué versión de macOS tienes en tu Mac actualmente? (Se ve en  → Acerca de este Mac). Define qué versión mínima soporta la app y qué APIs de SwiftUI/SwiftData podemos usar.

**Respuesta:** macOS 26 (Tahoe). Deployment target del proyecto configurado en macOS 14 (Sonoma) como piso seguro para SwiftData — corre sin problema en tu Mac y deja margen si en algún momento usas una Mac algo más vieja.

## 3. ¿Sumar también Apple Calendar/Recordatorios (iCloud)?

Es prácticamente gratis en esfuerzo (EventKit, sin OAuth) y te dejaría *todo* — Google + Microsoft + Apple — en una sola vista.

**Respuesta:** Sí, incluirlo. Pasa de "opcional" (Fase 7) a confirmado en el alcance.

## 4. Credenciales de Google y Microsoft

¿Ya tienes un proyecto en Google Cloud Console y una app registrada en Azure, o prefieres que te guíe paso a paso cuando lleguemos a la Fase 0/1?

**Respuesta:** No tienes ninguno. Guía paso a paso para Google en [guides/GOOGLE_CLOUD_SETUP.md](guides/GOOGLE_CLOUD_SETUP.md) (la de Azure la damos en la Fase 4, cuando toque integrar Microsoft, para no hacerte reunir credenciales que se van a quedar sin usar semanas).

## 5. Nombre de la app y bundle id (menor, se puede definir después)

Un nombre de trabajo y un bundle id (ej. `com.tunombre.calendario`) para configurar el proyecto Xcode.

**Respuesta:** _pendiente_
