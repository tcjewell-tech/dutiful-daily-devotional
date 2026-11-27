import XCTest
@testable import DutifulDailyDevotional

final class OrientationTests: XCTestCase {
    private let size = CGSize(width: 400, height: 800)

    func testSpotlightSurroundsAReportedControl() {
        let frames: [OrientationTarget: CGRect] = [.study: CGRect(x: 20, y: 300, width: 120, height: 40)]
        let hole = OrientationStep.spotlight(for: .study, frames: frames, size: size, bottomInset: 34)
        XCTAssertEqual(hole, CGRect(x: 14, y: 294, width: 132, height: 52))
    }

    func testNoSpotlightWhenControlIsUnknownOrOffScreen() {
        XCTAssertNil(OrientationStep.spotlight(for: .sos, frames: [:], size: size, bottomInset: 34))
        let scrolledAway: [OrientationTarget: CGRect] = [.study: CGRect(x: 20, y: 900, width: 120, height: 40)]
        XCTAssertNil(OrientationStep.spotlight(for: .study, frames: scrolledAway, size: size, bottomInset: 34))
    }

    func testTabBarSpotlightIsTheBottomStrip() {
        let hole = OrientationStep.spotlight(for: .tabBar(arrowAt: 0.5), frames: [:], size: size, bottomInset: 34)
        XCTAssertEqual(hole, CGRect(x: 0, y: 710, width: 400, height: 90))
    }

    func testEveryStepHasAUniqueTitle() {
        // Help uses the title as each row's identity.
        let titles = OrientationStep.all.map(\.title)
        XCTAssertEqual(Set(titles).count, titles.count)
    }
}
