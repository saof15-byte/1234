import SwiftUI

/// Rejilla de horas compartida por las vistas de día y de semana: la vista de
/// día es simplemente esta misma rejilla con una sola columna.
struct TimeGridView: View {
    let days: [Date]
    let math: CalendarMath

    private let hourHeight: CGFloat = 48
    private let gutterWidth: CGFloat = 56

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            ScrollView {
                ZStack(alignment: .topLeading) {
                    hourRows
                    nowIndicator
                }
            }
        }
    }

    private var header: some View {
        HStack(spacing: 0) {
            Color.clear.frame(width: gutterWidth)
            ForEach(days, id: \.self) { day in
                VStack(spacing: 2) {
                    Text(math.weekdaySymbol(for: day).uppercased())
                        .font(.caption2)
                        .foregroundStyle(math.isToday(day) ? GoogleCalendarColors.accent : .secondary)
                    Text(String(math.dayNumber(day)))
                        .font(.title3)
                        .foregroundStyle(math.isToday(day) ? .white : .primary)
                        .frame(width: 32, height: 32)
                        .background(math.isToday(day) ? GoogleCalendarColors.accent : Color.clear, in: Circle())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
            }
        }
    }

    private var hourRows: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 24, id: \.self) { hour in
                HStack(alignment: .top, spacing: 0) {
                    Text(math.hourLabel(hour))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .frame(width: gutterWidth, alignment: .trailing)
                        .padding(.trailing, 6)
                        .offset(y: -6)
                    ForEach(days, id: \.self) { _ in
                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .border(GoogleCalendarColors.gridLine, width: 0.5)
                    }
                }
                .frame(height: hourHeight)
            }
        }
    }

    @ViewBuilder
    private var nowIndicator: some View {
        if days.contains(where: { math.isToday($0) }) {
            HStack(spacing: 0) {
                Color.clear.frame(width: gutterWidth)
                Circle()
                    .fill(GoogleCalendarColors.nowIndicator)
                    .frame(width: 8, height: 8)
                Rectangle()
                    .fill(GoogleCalendarColors.nowIndicator)
                    .frame(height: 1)
            }
            .offset(y: CGFloat(math.fractionOfDay(for: Date())) * hourHeight * 24 - 4)
        }
    }
}
