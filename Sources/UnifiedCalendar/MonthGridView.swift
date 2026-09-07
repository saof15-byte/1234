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
        .background(Theme.background)
    }

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(math.weekdaySymbols, id: \.self) { symbol in
                Text(symbol.uppercased())
                    .font(Theme.Font.weekdayLabel)
                    .foregroundStyle(Theme.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Theme.Spacing.s)
            }
        }
    }

    private var grid: some View {
        VStack(spacing: 0) {
            ForEach(math.weeksInMonth(containing: anchor), id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) { day in
                        MonthDayCell(
                            isInAnchorMonth: math.isSameMonth(day, as: anchor),
                            isToday: math.isToday(day),
                            dayNumber: math.dayNumber(day)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(alignment: .top) {
                            Rectangle()
                                .fill(Theme.gridLine)
                                .frame(height: 1)
                        }
                        .overlay(alignment: .leading) {
                            Rectangle()
                                .fill(Theme.gridLine)
                                .frame(width: 1)
                        }
                    }
                }
            }
        }
    }
}

private struct MonthDayCell: View {
    let isInAnchorMonth: Bool
    let isToday: Bool
    let dayNumber: Int

    var body: some View {
        VStack(spacing: 0) {
            Text(String(dayNumber))
                .font(Theme.Font.dayNumber)
                .foregroundStyle(numberColor)
                .frame(width: 24, height: 24)
                .background(isToday ? Theme.accent : Color.clear, in: Circle())
                .padding(.top, Theme.Spacing.xs)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(isToday ? Theme.todayColumn : Color.clear)
    }

    private var numberColor: Color {
        if isToday { return Theme.onAccent }
        return isInAnchorMonth ? Theme.textPrimary : Theme.textSecondary
    }
}
