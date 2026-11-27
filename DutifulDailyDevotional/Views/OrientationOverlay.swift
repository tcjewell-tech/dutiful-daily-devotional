import Observation
import SwiftUI

/// What a walkthrough step points at.
enum OrientationTarget: Hashable {
    case reading, study, actions, help, sos
    /// The tab bar, with the arrow this far across the screen (0…1).
    /// shortcut: tab items aren't SwiftUI views, so the whole bar is lit and the arrow position is estimated
    /// from four equal tabs on a phone. Revisit if the tab count changes or the app gets an iPad layout.
    case tabBar(arrowAt: CGFloat)
}

/// Where each target currently is on screen (global coordinates), reported by `.orientationTarget(_:)`.
@Observable
final class OrientationFrames {
    var rects: [OrientationTarget: CGRect] = [:]
}

extension View {
    /// Reports this view's position so the walkthrough can cut a spotlight around it.
    func orientationTarget(_ target: OrientationTarget) -> some View {
        modifier(OrientationTargetModifier(target: target))
    }
}

private struct OrientationTargetModifier: ViewModifier {
    let target: OrientationTarget
    // Optional, so a view shown outside RootView simply isn't tracked.
    @Environment(OrientationFrames.self) private var frames: OrientationFrames?

    func body(content: Content) -> some View {
        content.onGeometryChange(for: CGRect.self) { $0.frame(in: .global) } action: { frames?.rects[target] = $0 }
    }
}

/// One walkthrough step. The same list fills the Help screen, so the two always agree.
struct OrientationStep {
    let tab: RootView.AppTab
    let target: OrientationTarget
    let symbol: String
    let title: String
    let text: String

    static let all = [
        OrientationStep(tab: .today, target: .reading, symbol: "sun.max", title: "Today",
                        text: "Each day brings one short passage and a reflection on it. It changes at midnight and needs no signal."),
        OrientationStep(tab: .today, target: .study, symbol: "book", title: "Study this",
                        text: "Opens questions for reflection, a private note that never leaves this device, and the passage in context."),
        OrientationStep(tab: .today, target: .actions, symbol: "heart", title: "Add to favorites and Share",
                        text: "Add to favorites keeps a reading for later. Share sends it to someone."),
        OrientationStep(tab: .archive, target: .tabBar(arrowAt: 0.5), symbol: "calendar", title: "Archive and Favorites",
                        text: "Archive lists every reading from this year so far. Favorites lists the ones you kept."),
        OrientationStep(tab: .settings, target: .tabBar(arrowAt: 0.875), symbol: "gearshape", title: "Settings",
                        text: "Change your tradition here. Discreet lock screen keeps the lock screen widget to the day's theme only."),
        OrientationStep(tab: .today, target: .sos, symbol: "phone", title: "SOS",
                        text: "At the top of each tab. Lists crisis and support lines you can call, day or night."),
        OrientationStep(tab: .today, target: .help, symbol: "questionmark.circle", title: "?",
                        text: "At the top of each tab. Opens this guide again."),
    ]

    /// The cut-out for a target in a full-screen overlay of `size`, or nil when there is nothing on screen to light up
    /// (then the card shows on its own). `frames` are global; `origin` is the overlay's own global origin.
    static func spotlight(for target: OrientationTarget, frames: [OrientationTarget: CGRect],
                          size: CGSize, origin: CGPoint = .zero, bottomInset: CGFloat) -> CGRect? {
        if case .tabBar = target {
            let height = bottomInset + 56
            return CGRect(x: 0, y: size.height - height, width: size.width, height: height)
        }
        guard let frame = frames[target], !frame.isEmpty else { return nil }
        let rect = frame.offsetBy(dx: -origin.x, dy: -origin.y).insetBy(dx: -6, dy: -6)
        return rect.intersects(CGRect(origin: .zero, size: size)) ? rect : nil
    }
}

/// Dims the app, cuts a spotlight around the control being described, and points an arrow at it.
struct OrientationOverlay: View {
    @Binding var selectedTab: RootView.AppTab
    let frames: [OrientationTarget: CGRect]
    let finish: () -> Void
    @State private var index = 0

    private let cardColor = Color(uiColor: .secondarySystemBackground)

    var body: some View {
        let steps = OrientationStep.all
        let step = steps[index]
        GeometryReader { proxy in
            let size = proxy.size
            let bottomInset = proxy.safeAreaInsets.bottom
            let hole = OrientationStep.spotlight(for: step.target, frames: frames, size: size,
                                                 origin: proxy.frame(in: .global).origin, bottomInset: bottomInset)
            // The card goes on whichever side of the spotlight has more room.
            let cardBelow = hole.map { $0.midY < size.height / 2 } ?? false
            let arrowX: CGFloat = {
                if case .tabBar(let fraction) = step.target { return size.width * fraction }
                return hole?.midX ?? 0
            }()

            ZStack(alignment: .topLeading) {
                Path { path in
                    path.addRect(CGRect(origin: .zero, size: size))
                    if let hole { path.addRoundedRect(in: hole, cornerSize: CGSize(width: 12, height: 12)) }
                }
                .fill(Color.black.opacity(0.6), style: FillStyle(eoFill: true))
                .contentShape(Rectangle())
                .onTapGesture {} // swallows taps everywhere, including inside the cut-out

                if let hole {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 2)
                        .frame(width: hole.width, height: hole.height)
                        .position(x: hole.midX, y: hole.midY)
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }

                VStack(spacing: 0) {
                    if cardBelow, let hole {
                        // Capped so a very tall spotlight can't push the card off the screen.
                        Color.clear.frame(height: min(hole.maxY + 4, size.height * 0.55))
                        arrow(up: true, x: arrowX, width: size.width)
                        card(step: step, count: steps.count)
                        Spacer(minLength: 0)
                    } else {
                        Spacer(minLength: 0)
                        card(step: step, count: steps.count)
                        if let hole {
                            arrow(up: false, x: arrowX, width: size.width)
                            Color.clear.frame(height: min(size.height - hole.minY + 4, size.height * 0.55))
                        } else {
                            Color.clear.frame(height: bottomInset + 72)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        // VoiceOver stays inside the card instead of reading the dimmed screen behind it.
        .accessibilityAddTraits(.isModal)
        .onChange(of: index, initial: true) { selectedTab = steps[index].tab }
    }

    private func arrow(up: Bool, x: CGFloat, width: CGFloat) -> some View {
        Image(systemName: up ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
            .font(.title2)
            .foregroundStyle(cardColor)
            .frame(width: 28)
            .padding(.leading, min(max(x - 14, 24), width - 52))
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityHidden(true)
    }

    private func card(step: OrientationStep, count: Int) -> some View {
        let isLast = index == count - 1
        return VStack(alignment: .leading, spacing: 12) {
            Label(step.title, systemImage: step.symbol)
                .font(.title3.bold())
                .accessibilityAddTraits(.isHeader)
            Text(step.text)
            HStack {
                Text("\(index + 1) of \(count)").font(.footnote).foregroundStyle(.secondary)
                Spacer()
                if !isLast { Button("Skip", action: finish) }
                Button(isLast ? "Done" : "Next") {
                    if isLast { finish() } else { index += 1 }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(cardColor, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
