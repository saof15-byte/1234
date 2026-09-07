import SwiftUI

/// Paleta aproximada a la de Google Calendar, para mantener consistencia visual
/// en toda la app. No son los assets/colores exactos de Google (evitar eso a
/// propósito, ver docs/ROADMAP.md Fase 8), sino una paleta inspirada en ella.
enum GoogleCalendarColors {
    static let accent = Color(red: 0x1A / 255, green: 0x73 / 255, blue: 0xE8 / 255)
    static let nowIndicator = Color(red: 0xEA / 255, green: 0x43 / 255, blue: 0x35 / 255)
    static let gridLine = Color(nsColor: .separatorColor)

    /// Colores de calendario/etiqueta al estilo de los "chips" de Google Calendar.
    static let eventPalette: [Color] = [
        Color(red: 0xD5 / 255, green: 0x00 / 255, blue: 0x00 / 255), // Tomato
        Color(red: 0xF4 / 255, green: 0x51 / 255, blue: 0x1E / 255), // Tangerine
        Color(red: 0xF6 / 255, green: 0xBF / 255, blue: 0x26 / 255), // Banana
        Color(red: 0x33 / 255, green: 0xB6 / 255, blue: 0x79 / 255), // Sage
        Color(red: 0x0B / 255, green: 0x80 / 255, blue: 0x43 / 255), // Basil
        Color(red: 0x03 / 255, green: 0x9B / 255, blue: 0xE5 / 255), // Peacock
        Color(red: 0x3F / 255, green: 0x51 / 255, blue: 0xB5 / 255), // Blueberry
        Color(red: 0x8E / 255, green: 0x24 / 255, blue: 0xAA / 255), // Grape
    ]
}
