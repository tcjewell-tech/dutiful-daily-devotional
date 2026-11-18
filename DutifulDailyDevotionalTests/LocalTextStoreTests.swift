import XCTest
@testable import DutifulDailyDevotional

/// Uses `Fixtures/Texts/web/John.json` (real WEB text for John 14:26-28), bundled in the test bundle.
final class LocalTextStoreTests: XCTestCase {
    private let store = LocalTextStore(bundle: Bundle(for: LocalTextStoreTests.self))

    private func john(_ verses: ClosedRange<Int>) -> SourceReference {
        SourceReference(work: "John", division: 14, verses: verses)
    }

    func testLoadsDivision() throws {
        let division = try XCTUnwrap(store.division(for: john(27...27), tradition: .christian))
        XCTAssertEqual(division.number, 14)
        XCTAssertEqual(division.verses.map(\.number), [26, 27, 28])
    }

    func testHighlightsOnlyReferencedVerses() throws {
        let reference = john(27...27)
        let division = try XCTUnwrap(store.division(for: reference, tradition: .christian))
        XCTAssertEqual(division.verses.filter { reference.contains(verse: $0.number) }.map(\.number), [27])
    }

    func testPassageTextJoinsRange() throws {
        let text = try XCTUnwrap(store.passageText(for: john(27...28), tradition: .christian))
        XCTAssertTrue(text.hasPrefix("Peace I leave with you."))
        XCTAssertTrue(text.hasSuffix("for the Father is greater than I."))
    }

    func testRangePastEndOfDivisionReturnsNil() {
        XCTAssertNil(store.passageText(for: john(28...30), tradition: .christian))
    }

    func testMissingWorkReturnsNil() {
        XCTAssertNil(store.division(for: SourceReference(work: "Acts", division: 1, verses: 1...1), tradition: .christian))
        XCTAssertNil(store.division(for: john(27...27), tradition: .jewish))
    }
}
