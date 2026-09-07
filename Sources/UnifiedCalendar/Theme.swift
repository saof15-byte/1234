import AppKit
import SwiftUI

/// Tokens de diseño tomados de Google Calendar.
///
/// Google no usa el mismo azul en claro y en oscuro: en modo oscuro aclara el
/// azul de #1A73E8 a #8AB4F8 para que no vibre contra el fondo, y baja el texto
/// blanco puro a #E8EAED. Por eso cada color se define como par claro/oscuro en
/// vez de un valor único.
enum Theme {
    static let accent = Color.googleDynamic(light: 0x1A73E8, dark: 0x8AB4F8)
    static let onAccent = Color.googleDynamic(light: 0xFFFFFF, dark: 0x202124)
    static let background = Color.googleDynamic(light: 0xFFFFFF, dark: 0x202124)
    static let surface = Color.googleDynamic(light: 0xFFFFFF, dark: 0x292A2D)
    static let gridLine = Color.googleDynamic(light: 0xDADCE0, dark: 0x3C4043)
    static let textPrimary = Color.googleDynamic(light: 0x3C4043, dark: 0xE8EAED)
    static let textSecondary = Color.googleDynamic(light: 0x70757A, dark: 0x9AA0A6)
    static let nowIndicator = Color.googleDynamic(light: 0xEA4335, dark: 0xF28B82)
    static let todayColumn = Color.googleDynamic(light: 0x1A73E8, dark: 0x8AB4F8).opacity(0.06)

    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 12
        static let l: CGFloat = 16
    }

    /// Escala tipográfica equivalente a la de Google Calendar.
    enum Font {
        static let dayNumberLarge = SwiftUI.Font.system(size: 24, weight: .regular)
        static let dayNumber = SwiftUI.Font.system(size: 12, weight: .regular)
        static let weekdayLabel = SwiftUI.Font.system(size: 11, weight: .medium)
        static let hourLabel = SwiftUI.Font.system(size: 10, weight: .regular)
        static let sidebarTitle = SwiftUI.Font.system(size: 13, weight: .medium)
        static let sidebarBody = SwiftUI.Font.system(size: 12, weight: .regular)
    }

    /// Los once colores con nombre que Google Calendar ofrece por calendario y
    /// por evento. Se usarán al pintar los eventos de cada cuenta.
    static let eventPalette: [EventColor] = [
        EventColor(name: "Tomate", hex: 0xD50000),
        EventColor(name: "Flamenco", hex: 0xE67C73),
        EventColor(name: "Mandarina", hex: 0xF4511E),
        EventColor(name: "Plátano", hex: 0xF6BF26),
        EventColor(name: "Salvia", hex: 0x33B679),
        EventColor(name: "Albahaca", hex: 0x0B8043),
        EventColor(name: "Pavo real", hex: 0x039BE5),
        EventColor(name: "Arándano", hex: 0x3F51B5),
        EventColor(name: "Lavanda", hex: 0x7986CB),
        EventColor(name: "Uva", hex: 0x8E24AA),
        EventColor(name: "Grafito", hex: 0x616161),
    ]
}

struct EventColor: Identifiable, Hashable {
    let name: String
    let hex: UInt32

    var id: String { name }
    var color: Color { Color(nsColor: NSColor(googleHex: hex)) }
}

extension Color {
    /// Color que cambia solo con la apariencia del sistema, sin que las vistas
    /// tengan que leer el `colorScheme` ni recalcularse.
    static func googleDynamic(light: UInt32, dark: UInt32) -> Color {
        Color(nsColor: NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
                ? NSColor(googleHex: dark)
                : NSColor(googleHex: light)
        })
    }
}

extension NSColor {
    convenience init(googleHex hex: UInt32) {
        self.init(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
