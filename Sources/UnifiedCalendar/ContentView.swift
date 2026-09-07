import SwiftUI

struct ContentView: View {
    @State private var mode: CalendarViewMode = .week
    @State private var anchor = Date()

    private let math = CalendarMath()

    var body: some View {
        NavigationSplitView {
            SidebarView(anchor: $anchor, math: math)
                .navigationSplitViewColumnWidth(min: 220, ideal: 240, max: 320)
        } detail: {
            calendarView
                .navigationTitle(math.title(for: mode, anchor: anchor))
                .toolbar { toolbarContent }
        }
    }

    @ViewBuilder
    private var calendarView: some View {
        switch mode {
        case .day:
            TimeGridView(days: [anchor], math: math)
        case .week:
            TimeGridView(days: math.daysInWeek(containing: anchor), math: math)
        case .month:
            MonthGridView(anchor: anchor, math: math)
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItemGroup {
            Button("Hoy") { anchor = Date() }
            Button { shift(-1) } label: { Image(systemName: "chevron.left") }
            Button { shift(1) } label: { Image(systemName: "chevron.right") }
            Picker("Vista", selection: $mode) {
                ForEach(CalendarViewMode.allCases) { mode in
                    Text(mode.title).tag(mode)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private func shift(_ value: Int) {
        if let next = math.calendar.date(byAdding: mode.step, value: value, to: anchor) {
            anchor = next
        }
    }
}

/// Calendarios de ejemplo para ver la forma de la barra lateral. Se reemplazan
/// por los calendarios reales de cada cuenta en la Fase 3.
private struct CalendarSource: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

private struct SidebarView: View {
    @Binding var anchor: Date
    let math: CalendarMath

    private let sources = [
        CalendarSource(name: "Personal", color: GoogleCalendarColors.eventPalette[5]),
        CalendarSource(name: "Trabajo", color: GoogleCalendarColors.eventPalette[3]),
        CalendarSource(name: "Tareas", color: GoogleCalendarColors.eventPalette[2]),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MiniMonthView(anchor: $anchor, math: math)
                .padding(12)
            Divider()
            List {
                Section("Cuentas") {
                    Text("Sin cuentas conectadas")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                Section("Mis calendarios") {
                    ForEach(sources) { source in
                        Label {
                            Text(source.name)
                        } icon: {
                            Circle()
                                .fill(source.color)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

#Preview {
    ContentView()
}
