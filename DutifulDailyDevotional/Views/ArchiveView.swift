import SwiftUI

/// One row per date from Jan 1 of this year through today, newest first.
struct ArchiveView: View {
    let tradition: Tradition

    var body: some View {
        let calendar = Calendar.current
        let entries = DevotionalStore().devotionals(for: tradition)
        let dates = Array(DevotionalProvider.datesThisYear(through: .now, calendar: calendar).reversed())
        NavigationStack {
            List(dates, id: \.self) { date in
                if let devotional = DevotionalProvider.devotional(from: entries, on: date, calendar: calendar) {
                    NavigationLink { DevotionalDetailView(devotional: devotional) } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(date, format: .dateTime.weekday(.abbreviated).month().day())
                                .font(.subheadline).foregroundStyle(.secondary)
                            Text(devotional.theme).font(.headline)
                        }
                    }
                }
            }
            .overlay {
                if entries.isEmpty {
                    ContentUnavailableView("Content unavailable", systemImage: "book.closed")
                }
            }
            .navigationTitle("Archive")
            .toolbar { SupportToolbar() }
        }
    }
}
