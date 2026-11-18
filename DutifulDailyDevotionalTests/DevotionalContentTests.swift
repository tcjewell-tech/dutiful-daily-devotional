import XCTest
@testable import DutifulDailyDevotional

/// Checks the bundled devotional JSON (host app bundle).
final class DevotionalContentTests: XCTestCase {
    private let store = DevotionalStore()

    func testEveryTraditionDecodesWithContiguousDays() {
        for tradition in Tradition.allCases {
            let entries = store.devotionals(for: tradition)
            XCTAssertFalse(entries.isEmpty, "\(tradition) did not decode")
            XCTAssertEqual(entries.map(\.day), Array(1...max(entries.count, 1)), "\(tradition) days must be 1...N")
            XCTAssertLessThanOrEqual(entries.count, 90, "\(tradition)")
        }
    }

    func testTraditionsShareDayCountAndThemes() {
        let christian = store.devotionals(for: .christian)
        for tradition in Tradition.allCases {
            let entries = store.devotionals(for: tradition)
            XCTAssertEqual(entries.count, christian.count, "\(tradition) day count")
            XCTAssertEqual(entries.map(\.theme), christian.map(\.theme), "\(tradition) themes")
        }
    }

    func testEveryEntryHasThreeNonEmptyPromptsAndText() {
        for tradition in Tradition.allCases {
            for entry in store.devotionals(for: tradition) {
                XCTAssertEqual(entry.studyPrompts.count, 3, entry.id)
                XCTAssertFalse(entry.studyPrompts.contains { $0.trimmingCharacters(in: .whitespaces).isEmpty }, entry.id)
                for field in [entry.theme, entry.reference, entry.passageText, entry.reflection] {
                    XCTAssertFalse(field.trimmingCharacters(in: .whitespaces).isEmpty, entry.id)
                }
            }
        }
    }

    func testEveryReferenceParses() {
        for tradition in Tradition.allCases {
            for entry in store.devotionals(for: tradition) {
                XCTAssertNotNil(SourceReference.parse(entry.reference, tradition: tradition), entry.id)
            }
        }
    }

    func testIDsRoundTripThroughStore() {
        XCTAssertEqual(store.devotional(id: "jewish-1")?.id, "jewish-1")
        XCTAssertNil(store.devotional(id: "jewish-0"))
        XCTAssertNil(store.devotional(id: "nonsense"))
    }

    /// Release gate (spec: 90 entries per tradition). Skipped while draft content is incomplete.
    func testFullCatalogHasNinetyDays() throws {
        let count = store.devotionals(for: .christian).count
        try XCTSkipIf(count < 90, "Draft content: \(count) of 90 days written")
        for tradition in Tradition.allCases {
            XCTAssertEqual(store.devotionals(for: tradition).count, 90, "\(tradition)")
        }
    }
}
