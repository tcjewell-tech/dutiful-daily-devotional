import Foundation

/// Picks the day's entry. Shared by app and widget so both always agree.
enum DevotionalProvider {
    /// Spec §5: `(dayOfYear - 1) % count`, so January 1 (day 1) shows the first entry.
    static func index(dayOfYear: Int, count: Int) -> Int {
        count > 0 ? max(dayOfYear - 1, 0) % count : 0
    }

    static func index(for date: Date, calendar: Calendar, count: Int) -> Int {
        index(dayOfYear: calendar.ordinality(of: .day, in: .year, for: date) ?? 1, count: count)
    }

    /// `entries` must be sorted by day, as `DevotionalStore` returns them.
    static func devotional(from entries: [Devotional], on date: Date, calendar: Calendar) -> Devotional? {
        guard !entries.isEmpty else { return nil }
        return entries[index(for: date, calendar: calendar, count: entries.count)]
    }

    static func today(for tradition: Tradition,
                      store: DevotionalStore = DevotionalStore(),
                      date: Date = .now,
                      calendar: Calendar = .current) -> Devotional? {
        devotional(from: store.devotionals(for: tradition), on: date, calendar: calendar)
    }

    static func nextMidnight(after date: Date, calendar: Calendar) -> Date {
        calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date))
            ?? date.addingTimeInterval(60 * 60)
    }

    /// Jan 1 of `date`'s year through `date`, one start-of-day per day.
    static func datesThisYear(through date: Date, calendar: Calendar) -> [Date] {
        guard let start = calendar.dateInterval(of: .year, for: date)?.start else { return [] }
        let today = calendar.startOfDay(for: date)
        return Array(sequence(first: start) { calendar.date(byAdding: .day, value: 1, to: $0) }
            .prefix { $0 <= today })
    }
}
