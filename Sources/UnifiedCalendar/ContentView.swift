import SwiftUI

struct ContentView: View {
    private let placeholderCalendars: [(name: String, color: Color)] = [
        ("Personal", GoogleCalendarColors.eventPalette[5]),
        ("Trabajo", GoogleCalendarColors.eventPalette[3]),
        ("Tareas", GoogleCalendarColors.eventPalette[2]),
    ]

    var body: some View {
        NavigationSplitView {
            SidebarView(calendars: placeholderCalendars)
        } detail: {
            WeekGridView()
        }
    }
}

private struct SidebarView: View {
    let calendars: [(name: String, color: Color)]

    var body: some View {
        List {
            Section("Cuentas") {
                Text("Agrega tu primera cuenta de Google en la Fase 1")
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }
            Section("Mis calendarios") {
                ForEach(calendars, id: \.name) { calendar in
                    Label {
                        Text(calendar.name)
                    } icon: {
                        Circle()
                            .fill(calendar.color)
                            .frame(width: 10, height: 10)
                    }
                }
            }
        }
        .navigationTitle("Calendario Unificado")
        .frame(minWidth: 220)
    }
}

private struct WeekGridView: View {
    private let days = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"]
    private let hours = Array(0..<24)

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Color.clear.frame(width: 50)
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                }
                Divider()
                ForEach(hours, id: \.self) { hour in
                    HStack(spacing: 0) {
                        Text(String(format: "%02d:00", hour))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                            .padding(.trailing, 4)
                        ForEach(days, id: \.self) { _ in
                            Rectangle()
                                .fill(GoogleCalendarColors.background)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .border(GoogleCalendarColors.gridLine, width: 0.5)
                        }
                    }
                }
            }
        }
        .navigationTitle("Esta semana")
    }
}

#Preview {
    ContentView()
}
