import XCTest
@testable import DutifulDailyDevotional

final class DeepLinkTests: XCTestCase {
    func testWidgetURLOpensToday() throws {
        XCTAssertEqual(DeepLink(url: try XCTUnwrap(AppConstants.todayURL)), .today)
    }

    func testOtherURLsAreIgnored() throws {
        XCTAssertNil(DeepLink(url: try XCTUnwrap(URL(string: "dutifuldevotional://archive"))))
        XCTAssertNil(DeepLink(url: try XCTUnwrap(URL(string: "otherapp://today"))))
    }
}
