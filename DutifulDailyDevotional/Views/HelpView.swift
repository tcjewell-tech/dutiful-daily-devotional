import SwiftUI

/// The ? and SOS buttons at the top of each tab.
struct SupportToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            NavigationLink { HelpView() } label: {
                Label("Help", systemImage: "questionmark.circle")
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink { NeedToTalkView() } label: {
                Text("SOS").fontWeight(.bold).foregroundStyle(.red)
            }
            .accessibilityHint("Crisis and support lines")
        }
    }
}

struct HelpView: View {
    @Environment(AppPreferences.self) private var preferences

    var body: some View {
        List {
            Section("What everything does") {
                ForEach(OrientationStep.all, id: \.title) { step in
                    Label {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(step.title).font(.headline)
                            Text(step.text).font(.subheadline)
                        }
                    } icon: {
                        Image(systemName: step.symbol)
                    }
                }
            }
            Section {
                Button("Show the walkthrough again") { preferences.hasSeenOrientation = false }
                NavigationLink("Need to talk?") { NeedToTalkView() }
                NavigationLink("Sources and privacy") { AboutView() }
            }
        }
        .navigationTitle("Help")
    }
}
