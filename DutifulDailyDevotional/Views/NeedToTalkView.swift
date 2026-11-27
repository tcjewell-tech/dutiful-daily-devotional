import SwiftUI

/// Static and offline. The only actions are user-initiated phone calls.
/// Crisis line numbers checked against veteranscrisisline.net on 2026-11-25; recheck all numbers before each release.
struct NeedToTalkView: View {
    var body: some View {
        List {
            Section {
                Text("If you are struggling or thinking about harming yourself, you don't have to face it alone. Help is available 24 hours a day.")
            }
            Section {
                call("Call 988, then press 1", number: "988")
                Label("Text 838255", systemImage: "message")
            } header: {
                Text("Military/Veterans Crisis Line")
            } footer: {
                Text("Free and confidential. For thoughts of suicide or any crisis.")
            }
            Section {
                call("Europe: +1 844-702-5495", number: "+18447025495")
                call("Pacific: +1 844-702-5493", number: "+18447025493")
                call("Middle East: +1 855-422-7719", number: "+18554227719")
                call("Africa: +1 888-482-6054", number: "+18884826054")
                call("Central and South America: +1 866-989-9599", number: "+18669899599")
            } header: {
                Text("Crisis line from overseas")
            } footer: {
                Text("On base, dial DSN 988. Off base, call the number for your region.")
            }
            Section {
                call("Military OneSource: 800-342-9647", number: "+18003429647")
                Label("Crisis Text Line: text HOME to 741741", systemImage: "message")
            } header: {
                Text("Stress, anxiety or worry")
            } footer: {
                Text("Military OneSource offers free, confidential counseling for service members and families, day or night. You don't need to be in crisis to call.")
            }
            Section("Sexual assault") {
                call("DoD Safe Helpline: 877-995-5247", number: "+18779955247")
            }
            Section("Chaplain") {
                Text("You can also talk with your unit chaplain, whatever your faith or none.")
            }
        }
        .navigationTitle("Need to talk?")
    }

    @ViewBuilder
    private func call(_ label: String, number: String) -> some View {
        if let url = URL(string: "tel:\(number)") {
            Link(destination: url) { Label(label, systemImage: "phone.fill") }
        }
    }
}
