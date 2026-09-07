import SwiftUI

/// Mini calendario de la barra lateral, para saltar de fecha rápido.
struct MiniMonthView: View {
    @Binding var anchor: Date
    let math: CalendarMath

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    var body: some View {
        VStack(spacing: 6) {
            header
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(math.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol.prefix(1).uppercased())
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                ForEach(math.weeksInMonth(containing: anchor).flatMap { $0 }, id: \.self) { day in
                    Button {
                        anchor = day
                    } label: {
                        Text(String(math.dayNumber(day)))
                            .font(.caption)
                            .foregroundStyle(color(for: day))
                            .frame(width: 22, height: 22)
                            .background(background(for: day), in: Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Text(math.title(for: .month, anchor: anchor))
                .font(.subheadline.weight(.medium))
            Spacer()
            Button { shiftMonth(-1) } label: { Image(systemName: "chevron.left") }
            Button { shiftMonth(1) } label: { Image(systemName: "chevron.right") }
        }
        .buttonStyle(.borderless)
    }

    private func color(for day: Date) -> Color {
        if math.isToday(day) { return .white }
        return math.isSameMonth(day, as: anchor) ? .primary : .secondary
    }

    private func background(for day: Date) -> Color {
        math.isToday(day) ? GoogleCalendarColors.accent : .clear
    }

    private func shiftMonth(_ value: Int) {
        if let next = math.calendar.date(byAdding: .month, value: value, to: anchor) {
            anchor = next
        }
    }
}
