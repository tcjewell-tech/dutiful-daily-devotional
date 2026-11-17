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

    func testJanuaryFirstIsIndexOne() throws {
        XCTAssertEqual(index(try date(2027, 1, 1)), 1)
    }

    func testDecember31InCommonYear() throws {
        XCTAssertEqual(index(try date(2026, 12, 31)), 365 % 90)
    }

    func testDecember31InLeapYear() throws {
        XCTAssertEqual(index(try date(2028, 12, 31)), 366 % 90)
    }

    func testFebruary29() throws {
        XCTAssertEqual(index(try date(2028, 2, 29)), 60)
    }

    func testYearRolloverRepeatsEarlyEntries() throws {
        // Known, accepted: Dec 27–31 show the same entries as Jan 1–5.
        XCTAssertEqual(index(try date(2026, 12, 27)), index(try date(2027, 1, 1)))
        XCTAssertEqual(index(try date(2026, 12, 31)), index(try date(2027, 1, 5)))
    }

    func testLocalMidnightBoundary() throws {
        var utc = Calendar(identifier: .gregorian)
        utc.timeZone = .gmt
        // 08:00 UTC on Jan 1 is midnight in Los Angeles (PST, UTC-8).
        let beforeMidnight = try XCTUnwrap(utc.date(from: DateComponents(year: 2027, month: 1, day: 1, hour: 7, minute: 59, second: 59)))
        let atMidnight = try XCTUnwrap(utc.date(from: DateComponents(year: 2027, month: 1, day: 1, hour: 8)))
        XCTAssertEqual(index(beforeMidnight), 365 % 90)
        XCTAssertEqual(index(atMidnight), 1)
    }

    func testPicksEntryAtIndexFromSortedEntries() throws {
        let entries = (1...10).map {
            Devotional(tradition: .christian, day: $0, theme: "T\($0)", reference: "", passageText: "",
                       reflection: "", studyPrompts: [])
        }
        // Jan 3 → day of year 3 → 3 % 10 = index 3 → day 4.
        XCTAssertEqual(DevotionalProvider.devotional(from: entries, on: try date(2027, 1, 3), calendar: calendar)?.day, 4)
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
