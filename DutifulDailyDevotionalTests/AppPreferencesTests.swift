import Observation
import XCTest
@testable import DutifulDailyDevotional

/// Replaces the slow UI test: Settings and Today share one `AppPreferences`, so a change must notify readers and persist.
final class AppPreferencesTests: XCTestCase {
    private var suiteName = ""
    private var store = UserDefaults.standard

    override func setUpWithError() throws {
        suiteName = "AppPreferencesTests-\(UUID().uuidString)"
        store = try XCTUnwrap(UserDefaults(suiteName: suiteName))
    }

    override func tearDown() {
        store.removePersistentDomain(forName: suiteName)
    }

    func testFreshStoreHasNoTraditionAndDiscreetOn() {
        let preferences = AppPreferences(store: store)
        XCTAssertNil(preferences.selectedTradition)
        XCTAssertTrue(preferences.discreetLockScreen)
    }

    func testChangingTraditionNotifiesReadersAndPersists() {
        let preferences = AppPreferences(store: store)
        preferences.selectedTradition = .christian

        // What a view's body does: read the value inside observation tracking.
        let notified = expectation(description: "views reading the tradition re-render")
        withObservationTracking { _ = preferences.selectedTradition } onChange: { notified.fulfill() }

        preferences.selectedTradition = .jewish

        wait(for: [notified], timeout: 1)
        XCTAssertEqual(preferences.selectedTradition, .jewish)
        XCTAssertEqual(store.string(forKey: UserPreferences.selectedTraditionKey), "jewish")
        XCTAssertEqual(AppPreferences(store: store).selectedTradition, .jewish, "a relaunch would lose the choice")
    }

    func testDiscreetLockScreenPersists() {
        let preferences = AppPreferences(store: store)
        preferences.discreetLockScreen = false
        XCTAssertEqual(store.object(forKey: UserPreferences.discreetLockScreenKey) as? Bool, false)
        XCTAssertFalse(AppPreferences(store: store).discreetLockScreen)
    }

    func testUnknownStoredTraditionReadsAsNone() {
        store.set("unknown", forKey: UserPreferences.selectedTraditionKey)
        XCTAssertNil(AppPreferences(store: store).selectedTradition)
    }
}
