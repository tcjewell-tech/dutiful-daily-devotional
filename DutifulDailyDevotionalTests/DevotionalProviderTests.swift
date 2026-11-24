import XCTest
@testable import DutifulDailyDevotional

final class DevotionalProviderTests: XCTestCase {
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "America/Los_Angeles") ?? .gmt
        return calendar
    }

    private func date(_ year: Int, _ month: Int, _ day: Int, hour: Int = 12) throws -> Date {
        try XCTUnwrap(calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour)))
    }

    private func index(_ date: Date) -> Int {
        DevotionalProvider.index(for: date, calendar: calendar, count: 90)
    }

    func testJanuaryFirstIsIndexZero() throws {
        XCTAssertEqual(index(try date(2027, 1, 1)), 0)
    }

    func testDecember31InCommonYear() throws {
        XCTAssertEqual(index(try date(2026, 12, 31)), 364 % 90)
    }

    func testDecember31InLeapYear() throws {
        XCTAssertEqual(index(try date(2028, 12, 31)), 365 % 90)
    }

    func testFebruary29() throws {
        XCTAssertEqual(index(try date(2028, 2, 29)), 59)
    }

    func testNoEntriesOrBadDayGivesIndexZero() {
        XCTAssertEqual(DevotionalProvider.index(dayOfYear: 5, count: 0), 0)
        XCTAssertEqual(DevotionalProvider.index(dayOfYear: 0, count: 90), 0)
    }

    func testLocalMidnightBoundary() throws {
        var utc = Calendar(identifier: .gregorian)
        utc.timeZone = .gmt
        // 08:00 UTC on Jan 1 is midnight in Los Angeles (PST, UTC-8).
        let beforeMidnight = try XCTUnwrap(utc.date(from: DateComponents(year: 2027, month: 1, day: 1, hour: 7, minute: 59, second: 59)))
        let atMidnight = try XCTUnwrap(utc.date(from: DateComponents(year: 2027, month: 1, day: 1, hour: 8)))
        XCTAssertEqual(index(beforeMidnight), 364 % 90)
        XCTAssertEqual(index(atMidnight), 0)
    }

    /// `Shared/TestFixtures/day_selection_cases.json` is also checked by the Android ContentTest.
    func testSharedDaySelectionFixture() throws {
        struct Fixture: Decodable {
            struct Case: Decodable { let date: String; let count: Int; let index: Int }
            let cases: [Case]
        }
        let url = try XCTUnwrap(Bundle(for: Self.self).url(forResource: "day_selection_cases", withExtension: "json"))
        let fixture = try JSONDecoder().decode(Fixture.self, from: Data(contentsOf: url))
        XCTAssertFalse(fixture.cases.isEmpty)
        for testCase in fixture.cases {
            let parts = testCase.date.split(separator: "-").compactMap { Int($0) }
            XCTAssertEqual(parts.count, 3, testCase.date)
            guard parts.count == 3 else { continue }
            let day = try date(parts[0], parts[1], parts[2])
            XCTAssertEqual(DevotionalProvider.index(for: day, calendar: calendar, count: testCase.count), testCase.index,
                           "\(testCase.date) with \(testCase.count) entries")
        }
    }

    func testPicksEntryAtIndexFromSortedEntries() throws {
        let entries = (1...10).map {
            Devotional(tradition: .christian, day: $0, theme: "T\($0)", reference: "", passageText: "",
                       reflection: "", studyPrompts: [])
        }
        // Jan 3 → day of year 3 → (3 - 1) % 10 = index 2 → day 3.
        XCTAssertEqual(DevotionalProvider.devotional(from: entries, on: try date(2027, 1, 3), calendar: calendar)?.day, 3)
    }

    func testNoEntriesGivesNil() throws {
        XCTAssertNil(DevotionalProvider.devotional(from: [], on: try date(2027, 1, 1), calendar: calendar))
    }

    func testNextMidnightIsStartOfNextLocalDay() throws {
        let next = DevotionalProvider.nextMidnight(after: try date(2027, 3, 13, hour: 15), calendar: calendar)
        XCTAssertEqual(next, try date(2027, 3, 14, hour: 0))
    }

    func testArchiveDatesRunFromJanuaryFirstThroughToday() throws {
        let dates = DevotionalProvider.datesThisYear(through: try date(2028, 3, 1, hour: 9), calendar: calendar)
        XCTAssertEqual(dates.count, 61)
        XCTAssertEqual(dates.first, try date(2028, 1, 1, hour: 0))
        XCTAssertEqual(dates.last, try date(2028, 3, 1, hour: 0))
    }
}
