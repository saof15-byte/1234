import SwiftUI

/// Mini calendario de la barra lateral, para saltar de fecha rápido.
struct MiniMonthView: View {
    @Binding var anchor: Date
    let math: CalendarMath

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    var body: some View {
        VStack(spacing: Theme.Spacing.s) {
            header
            LazyVGrid(columns: columns, spacing: Theme.Spacing.xs) {
                ForEach(math.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol.prefix(1).uppercased())
                        .font(Theme.Font.hourLabel)
                        .foregroundStyle(Theme.textSecondary)
                }
                ForEach(math.weeksInMonth(containing: anchor).flatMap { $0 }, id: \.self) { day in
                    Button {
                        anchor = day
                    } label: {
                        Text(String(math.dayNumber(day)))
                            .font(Theme.Font.dayNumber)
                            .foregroundStyle(color(for: day))
                            .frame(width: 24, height: 24)
                            .background(background(for: day), in: Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var header: some View {
        HStack(spacing: Theme.Spacing.xs) {
            Text(math.title(for: .month, anchor: anchor))
                .font(Theme.Font.sidebarTitle)
                .foregroundStyle(Theme.textPrimary)
            Spacer()
            Button { shiftMonth(-1) } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Theme.textSecondary)
            }
            Button { shiftMonth(1) } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Theme.textSecondary)
            }
        }
        .buttonStyle(.borderless)
    }

    private func color(for day: Date) -> Color {
        if math.isToday(day) { return Theme.onAccent }
        return math.isSameMonth(day, as: anchor) ? Theme.textPrimary : Theme.textSecondary
    }

    private func background(for day: Date) -> Color {
        math.isToday(day) ? Theme.accent : .clear
    }

    private func shiftMonth(_ value: Int) {
        if let next = math.calendar.date(byAdding: .month, value: value, to: anchor) {
            anchor = next
        }
    }
}
