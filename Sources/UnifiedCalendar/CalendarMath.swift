import Foundation

/// Cálculos de fechas para las vistas de calendario. Usa el `Calendar` del
/// sistema, así que respeta el primer día de la semana y el idioma que tengas
/// configurados en el Mac.
struct CalendarMath {
    let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    func startOfWeek(for date: Date) -> Date {
        calendar.dateInterval(of: .weekOfYear, for: date)?.start
            ?? calendar.startOfDay(for: date)
    }

    func daysInWeek(containing date: Date) -> [Date] {
        let start = startOfWeek(for: date)
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    /// Las seis semanas que cubren el mes de `date`, incluyendo los días de
    /// relleno del mes anterior y el siguiente, igual que la vista de mes de
    /// Google Calendar.
    func weeksInMonth(containing date: Date) -> [[Date]] {
        guard let month = calendar.dateInterval(of: .month, for: date) else { return [] }
        let firstCell = startOfWeek(for: month.start)
        let days = (0..<42).compactMap { calendar.date(byAdding: .day, value: $0, to: firstCell) }
        guard days.count == 42 else { return [] }
        return stride(from: 0, to: 42, by: 7).map { Array(days[$0 ..< $0 + 7]) }
    }

    func isSameMonth(_ date: Date, as other: Date) -> Bool {
        calendar.isDate(date, equalTo: other, toGranularity: .month)
    }

    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    func dayNumber(_ date: Date) -> Int {
        calendar.component(.day, from: date)
    }

    /// Fracción del día ya transcurrida, para posicionar la línea de "ahora".
    func fractionOfDay(for date: Date) -> Double {
        let start = calendar.startOfDay(for: date)
        return date.timeIntervalSince(start) / 86_400
    }

    /// Símbolos cortos de los días, rotados según el primer día de la semana.
    var weekdaySymbols: [String] {
        let symbols = calendar.shortWeekdaySymbols
        let shift = calendar.firstWeekday - 1
        guard shift > 0, shift < symbols.count else { return symbols }
        return Array(symbols[shift...] + symbols[..<shift])
    }

    func weekdaySymbol(for date: Date) -> String {
        DateFormatters.weekday.string(from: date)
    }

    func hourLabel(_ hour: Int) -> String {
        guard hour > 0 else { return "" }
        let base = calendar.startOfDay(for: Date())
        guard let date = calendar.date(byAdding: .hour, value: hour, to: base) else { return "" }
        return DateFormatters.hour.string(from: date)
    }

    func title(for mode: CalendarViewMode, anchor: Date) -> String {
        switch mode {
        case .day:
            return DateFormatters.dayTitle.string(from: anchor)
        case .week:
            let days = daysInWeek(containing: anchor)
            guard let first = days.first, let last = days.last else { return "" }
            return "\(DateFormatters.weekTitle.string(from: first)) – \(DateFormatters.weekTitle.string(from: last))"
        case .month:
            return DateFormatters.monthTitle.string(from: anchor)
        }
    }
}

/// Los `DateFormatter` son caros de construir, así que se crean una sola vez.
private enum DateFormatters {
    static let weekday = template("EEE")
    static let hour = template("j")
    static let dayTitle = template("EEEEdMMMM")
    static let weekTitle = template("dMMM")
    static let monthTitle = template("MMMMyyyy")

    private static func template(_ template: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(template)
        return formatter
    }
}
