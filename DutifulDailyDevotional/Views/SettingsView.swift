import SwiftUI

struct SettingsView: View {
    // RootView's instance: a second copy here (it used to be @AppStorage) didn't reliably update Today and widgets.
    @Bindable var preferences: AppPreferences

    var body: some View {
        NavigationStack {
            Form {
                Section("Tradition") {
                    Picker("Tradition", selection: $preferences.selectedTradition) {
                        ForEach(Tradition.allCases) { Text($0.displayName).tag(Optional($0)) }
                    }
                }
                Section {
                    Toggle("Discreet lock screen", isOn: $preferences.discreetLockScreen)
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
            .toolbar { SupportToolbar() }
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
