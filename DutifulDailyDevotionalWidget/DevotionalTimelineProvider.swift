import WidgetKit

struct DevotionalEntry: TimelineEntry {
    let date: Date
    let devotional: Devotional?
    let discreet: Bool
}

struct DevotionalTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> DevotionalEntry {
        DevotionalEntry(date: .now, devotional: nil, discreet: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (DevotionalEntry) -> Void) {
        completion(entry(for: .now))
    }

    /// One entry per day; the app also reloads timelines when tradition or discreet mode changes.
    func getTimeline(in context: Context, completion: @escaping (Timeline<DevotionalEntry>) -> Void) {
        let now = Date.now
        let refresh = DevotionalProvider.nextMidnight(after: now, calendar: .current)
        completion(Timeline(entries: [entry(for: now)], policy: .after(refresh)))
    }

    private func entry(for date: Date) -> DevotionalEntry {
        let devotional = UserPreferences.selectedTradition.flatMap { DevotionalProvider.today(for: $0, date: date) }
        return DevotionalEntry(date: date, devotional: devotional, discreet: UserPreferences.discreetLockScreen)
    }
}
