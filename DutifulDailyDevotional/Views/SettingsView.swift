import SwiftUI

struct SettingsView: View {
    @AppStorage(UserPreferences.selectedTraditionKey, store: UserPreferences.defaults)
    private var traditionRaw = ""
    @AppStorage(UserPreferences.discreetLockScreenKey, store: UserPreferences.defaults)
    private var discreetLockScreen = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Tradition") {
                    Picker("Tradition", selection: $traditionRaw) {
                        ForEach(Tradition.allCases) { Text($0.displayName).tag($0.rawValue) }
                    }
                }
                Section {
                    Toggle("Discreet lock screen", isOn: $discreetLockScreen)
                } footer: {
                    Text("When on, the lock screen widget shows only the day's theme, with no reference or tradition.")
                }
                Section("Support") {
                    NavigationLink("Need to talk?") { NeedToTalkView() }
                }
                Section("About") {
                    NavigationLink("Sources and privacy") { AboutView() }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct AboutView: View {
    var body: some View {
        List {
            Section("Privacy") {
                Text("This app has no network access, no accounts, no analytics and no ads. Favorites and notes stay on this device and are excluded from backups.")
            }
            Section("Sources") {
                ForEach(Tradition.allCases) { tradition in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tradition.displayName).font(.headline)
                        Text(tradition.sourceAttribution).font(.subheadline)
                    }
                }
            }
            Section("Reflections") {
                Text("Daily reflections and study questions are written for this app.")
            }
        }
        .navigationTitle("Sources and privacy")
    }
}
