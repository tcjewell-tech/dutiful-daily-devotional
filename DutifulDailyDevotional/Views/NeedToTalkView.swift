import SwiftUI

/// Static and offline. The only action is a user-initiated phone call.
struct NeedToTalkView: View {
    var body: some View {
        List {
            Section {
                Text("If you are struggling or thinking about harming yourself, you don't have to face it alone. Help is available 24 hours a day.")
            }
            Section("Military/Veterans Crisis Line") {
                if let url = URL(string: "tel:988") {
                    Link(destination: url) {
                        Label("Call 988, then press 1", systemImage: "phone.fill")
                    }
                }
                Label("Text 838255", systemImage: "message")
            }
            Section("Chaplain") {
                Text("You can also talk with your unit chaplain, whatever your faith or none.")
            }
        }
        .navigationTitle("Need to talk?")
    }
}
