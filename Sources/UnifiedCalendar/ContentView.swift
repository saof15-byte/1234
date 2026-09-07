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

private struct SidebarView: View {
    @Binding var anchor: Date
    let math: CalendarMath

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MiniMonthView(anchor: $anchor, math: math)
                .padding(Theme.Spacing.m)
            Divider()
            calendarsSection
            Spacer(minLength: 0)
        }
    }

    /// Todavía no hay cuentas conectadas, así que en vez de calendarios de
    /// mentira la barra lateral explica qué falta. La lista real llega con la
    /// Fase 3 (ver docs/ROADMAP.md).
    private var calendarsSection: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Text("Mis calendarios")
                .font(Theme.Font.sidebarTitle)
                .foregroundStyle(Theme.textPrimary)

            HStack(alignment: .top, spacing: Theme.Spacing.s) {
                Image(systemName: "calendar.badge.plus")
                    .foregroundStyle(Theme.textSecondary)
                Text("Conecta una cuenta de Google o Microsoft para ver tus calendarios aquí.")
                    .font(Theme.Font.sidebarBody)
                    .foregroundStyle(Theme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(Theme.Spacing.m)
    }
}

#Preview {
    ContentView()
}
