import XCTest
@testable import DutifulDailyDevotional

final class SourceReferenceTests: XCTestCase {
    private func parse(_ text: String, _ tradition: Tradition) -> SourceReference? {
        SourceReference.parse(text, tradition: tradition)
    }

    func testBibleVerseAndRange() {
        XCTAssertEqual(parse("John 14:27", .christian), SourceReference(work: "John", division: 14, verses: 27...27))
        XCTAssertEqual(parse("Philippians 4:6-7", .christian), SourceReference(work: "Philippians", division: 4, verses: 6...7))
    }

    func testNumberedBook() {
        XCTAssertEqual(parse("1 John 4:19", .christian), SourceReference(work: "1 John", division: 4, verses: 19...19))
    }

    func testTanakhUsesHebrewNumbering() {
        XCTAssertEqual(parse("Psalms 46:2", .jewish), SourceReference(work: "Psalms", division: 46, verses: 2...2))
    }

    func testQuran() {
        XCTAssertEqual(parse("Qur'an 2:286", .muslim), SourceReference(work: "2", division: 2, verses: 286...286))
        XCTAssertEqual(parse("Qur'an 94:5-6", .muslim), SourceReference(work: "94", division: 94, verses: 5...6))
        XCTAssertEqual(parse("Qur’an 94:5", .muslim), SourceReference(work: "94", division: 94, verses: 5...5))
    }

    func testStoicFormats() {
        XCTAssertEqual(parse("Meditations 4.3", .humanist), SourceReference(work: "Meditations", division: 4, verses: 3...3))
        XCTAssertEqual(parse("Enchiridion 5", .humanist), SourceReference(work: "Enchiridion", division: 5, verses: nil))
        XCTAssertEqual(parse("Seneca, Letters 13.4", .humanist), SourceReference(work: "Letters", division: 13, verses: 4...4))
    }

    func testWholeDivisionContainsEveryVerse() {
        XCTAssertTrue(SourceReference(work: "Enchiridion", division: 5, verses: nil).contains(verse: 1))
        XCTAssertFalse(SourceReference(work: "John", division: 14, verses: 27...27).contains(verse: 26))
    }

    func testInvalidInput() {
        for text in ["", "John", "John 14", "John 14:9-3", "John 0:1", "John 14:0"] {
            XCTAssertNil(parse(text, .christian), text)
        }
        XCTAssertNil(parse("Qur'an 0:1", .muslim))
        XCTAssertNil(parse("Qur'an 115:1", .muslim))
        XCTAssertNil(parse("Meditations 4:3", .humanist))
        XCTAssertNil(parse("Enchiridion 0", .humanist))
    }
}
