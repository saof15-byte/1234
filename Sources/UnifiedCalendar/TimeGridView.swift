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
            ScrollViewReader { proxy in
                ScrollView {
                    ZStack(alignment: .topLeading) {
                        hourRows
                        nowIndicator
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        proxy.scrollTo(initialScrollHour, anchor: .center)
                    }
                }
            }
        }
        .background(Theme.background)
    }

    /// Al abrir, la rejilla se posiciona en la hora actual en vez de en la
    /// medianoche. Si el día de hoy no está a la vista, arranca en la mañana.
    private var initialScrollHour: Int {
        guard days.contains(where: { math.isToday($0) }) else { return 8 }
        return math.calendar.component(.hour, from: Date())
    }

    private var header: some View {
        HStack(spacing: 0) {
            Color.clear.frame(width: gutterWidth)
            ForEach(days, id: \.self) { day in
                VStack(spacing: Theme.Spacing.xs) {
                    Text(math.weekdaySymbol(for: day).uppercased())
                        .font(Theme.Font.weekdayLabel)
                        .foregroundStyle(math.isToday(day) ? Theme.accent : Theme.textSecondary)
                    Text(String(math.dayNumber(day)))
                        .font(Theme.Font.dayNumberLarge)
                        .foregroundStyle(math.isToday(day) ? Theme.onAccent : Theme.textPrimary)
                        .frame(width: 40, height: 40)
                        .background(math.isToday(day) ? Theme.accent : Color.clear, in: Circle())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, Theme.Spacing.s)
            }
        }
        .background(Theme.background)
    }

    private var hourRows: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 24, id: \.self) { hour in
                HStack(alignment: .top, spacing: 0) {
                    Text(math.hourLabel(hour))
                        .font(Theme.Font.hourLabel)
                        .foregroundStyle(Theme.textSecondary)
                        .frame(width: gutterWidth, alignment: .trailing)
                        .padding(.trailing, Theme.Spacing.s)
                        .offset(y: -5)
                    ForEach(days, id: \.self) { day in
                        Rectangle()
                            .fill(math.isToday(day) ? Theme.todayColumn : Color.clear)
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
                .frame(height: hourHeight)
                .id(hour)
            }
        }
    }

    @ViewBuilder
    private var nowIndicator: some View {
        if days.contains(where: { math.isToday($0) }) {
            HStack(spacing: 0) {
                Color.clear.frame(width: gutterWidth)
                Circle()
                    .fill(Theme.nowIndicator)
                    .frame(width: 10, height: 10)
                Rectangle()
                    .fill(Theme.nowIndicator)
                    .frame(height: 2)
            }
            .offset(y: CGFloat(math.fractionOfDay(for: Date())) * hourHeight * 24 - 5)
        }
    }
}
