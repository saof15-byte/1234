import Foundation

enum CalendarViewMode: String, CaseIterable, Identifiable {
    case day
    case week
    case month

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day: return "Día"
        case .week: return "Semana"
        case .month: return "Mes"
        }
    }

    /// Unidad por la que avanzan los botones de anterior/siguiente.
    var step: Calendar.Component {
        switch self {
        case .day: return .day
        case .week: return .weekOfYear
        case .month: return .month
        }
    }
}
