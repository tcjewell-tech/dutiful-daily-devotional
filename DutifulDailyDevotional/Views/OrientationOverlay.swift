import SwiftUI

/// One walkthrough step. The same list fills the Help screen, so the two always agree.
struct OrientationStep {
    let tab: RootView.AppTab
    let symbol: String
    let title: String
    let text: String

    static let all = [
        OrientationStep(tab: .today, symbol: "sun.max", title: "Today",
                        text: "Each day brings one short passage and a reflection on it. It changes at midnight and needs no signal."),
        OrientationStep(tab: .today, symbol: "book", title: "Study this",
                        text: "Opens questions for reflection, a private note that never leaves this device, and the passage in context."),
        OrientationStep(tab: .today, symbol: "heart", title: "Add to favorites and Share",
                        text: "Add to favorites keeps a reading for later. Share sends it to someone."),
        OrientationStep(tab: .archive, symbol: "calendar", title: "Archive and Favorites",
                        text: "Archive lists every reading from this year so far. Favorites lists the ones you kept."),
        OrientationStep(tab: .settings, symbol: "gearshape", title: "Settings",
                        text: "Change your tradition here. Discreet lock screen keeps the lock screen widget to the day's theme only."),
        OrientationStep(tab: .today, symbol: "questionmark.circle", title: "SOS and ?",
                        text: "At the top of each tab, SOS lists crisis and support lines you can call, and ? opens this guide again."),
    ]
}

/// Dims the app and walks through the steps, switching tabs so the screen being described shows behind the card.
struct OrientationOverlay: View {
    @Binding var selectedTab: RootView.AppTab
    let finish: () -> Void
    @State private var index = 0

    var body: some View {
        let steps = OrientationStep.all
        let step = steps[index]
        let isLast = index == steps.count - 1
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12) {
                Label(step.title, systemImage: step.symbol)
                    .font(.title3.bold())
                    .accessibilityAddTraits(.isHeader)
                Text(step.text)
                HStack {
                    Text("\(index + 1) of \(steps.count)").font(.footnote).foregroundStyle(.secondary)
                    Spacer()
                    if !isLast { Button("Skip", action: finish) }
                    Button(isLast ? "Done" : "Next") {
                        if isLast { finish() } else { index += 1 }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
            .padding()
            .padding(.bottom, 56) // clear of the tab bar, so the tab being described stays visible
        }
        // VoiceOver stays inside the card instead of reading the dimmed screen behind it.
        .accessibilityAddTraits(.isModal)
        .onChange(of: index, initial: true) { selectedTab = steps[index].tab }
    }
}
