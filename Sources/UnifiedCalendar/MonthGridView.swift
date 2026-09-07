import SwiftUI

struct MonthGridView: View {
    let anchor: Date
    let math: CalendarMath

    var body: some View {
        VStack(spacing: 0) {
            weekdayHeader
            Divider()
            grid
        }
    }

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(math.weekdaySymbols, id: \.self) { symbol in
                Text(symbol.uppercased())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
        }
    }

    private var grid: some View {
        VStack(spacing: 0) {
            ForEach(math.weeksInMonth(containing: anchor), id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) { day in
                        MonthDayCell(
                            date: day,
                            isInAnchorMonth: math.isSameMonth(day, as: anchor),
                            isToday: math.isToday(day),
                            dayNumber: math.dayNumber(day)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(GoogleCalendarColors.gridLine, width: 0.5)
                    }
                }
            }
        }
    }
}

private struct MonthDayCell: View {
    let date: Date
    let isInAnchorMonth: Bool
    let isToday: Bool
    let dayNumber: Int

    var body: some View {
        VStack(spacing: 0) {
            Text(String(dayNumber))
                .font(.callout)
                .foregroundStyle(numberColor)
                .frame(width: 24, height: 24)
                .background(isToday ? GoogleCalendarColors.accent : Color.clear, in: Circle())
                .padding(.top, 4)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    private var numberColor: Color {
        if isToday { return .white }
        return isInAnchorMonth ? .primary : .secondary
    }
}
