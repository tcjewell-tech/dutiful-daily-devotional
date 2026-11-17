import SwiftUI
import UIKit

struct TodayView: View {
    let tradition: Tradition
    @State private var now = Date.now

    var body: some View {
        NavigationStack {
            Group {
                if let devotional = DevotionalProvider.today(for: tradition, date: now) {
                    DevotionalDetailView(devotional: devotional)
                } else {
                    ContentUnavailableView("Content unavailable", systemImage: "book.closed")
                }
            }
            .navigationTitle("Today")
            .toolbar {
                NavigationLink { NeedToTalkView() } label: {
                    Label("Need to talk?", systemImage: "phone")
                }
            }
        }
        // Posted at local midnight (queued while suspended), so Today moves on without a relaunch.
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
            now = .now
        }
    }
}

/// One reading with its actions. Reused by Today, Archive and Favorites.
struct DevotionalDetailView: View {
    let devotional: Devotional

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DevotionalCardView(devotional: devotional)
                NavigationLink { StudyView(devotional: devotional) } label: {
                    Label("Study this", systemImage: "book")
                }
                .buttonStyle(.borderedProminent)
                HStack {
                    FavoriteButton(devotionalID: devotional.id)
                    ShareLink(item: devotional.shareText) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
