import XCTest

/// Regression test: changing the tradition in Settings must change what Today shows, without a relaunch.
final class TraditionSwitchUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testTodayFollowsTraditionChangedInSettings() {
        // A fresh simulator starts on onboarding; a reused one may already have a tradition.
        let onboardingChoice = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Christian'")).firstMatch
        if onboardingChoice.waitForExistence(timeout: 5) { onboardingChoice.tap() }

        choose("Christian")
        let christian = todayPassage()
        choose("Jewish")
        let jewish = todayPassage()

        XCTAssertNotEqual(christian, jewish, "Today still shows the previous tradition")
    }

    private func choose(_ tradition: String) {
        app.tabBars.buttons["Settings"].tap()
        // The Form's menu-style picker row reads "Tradition" (some iOS versions append the current value).
        let picker = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Tradition'")).firstMatch
        XCTAssertTrue(picker.waitForExistence(timeout: 5))
        picker.tap()
        let option = app.buttons[tradition]
        XCTAssertTrue(option.waitForExistence(timeout: 5), "\(tradition) option")
        option.tap()
    }

    private func todayPassage() -> String {
        app.tabBars.buttons["Today"].tap()
        let passage = app.descendants(matching: .any)["devotionalPassage"]
        XCTAssertTrue(passage.waitForExistence(timeout: 5))
        return passage.label
    }
}
