import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Query(sort: \FavoriteMark.createdAt, order: .reverse) private var marks: [FavoriteMark]
    private let store = DevotionalStore()

    var body: some View {
        NavigationStack {
            List(marks) { mark in
                if let devotional = store.devotional(id: mark.devotionalID) {
                    NavigationLink { DevotionalDetailView(devotional: devotional) } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(devotional.theme).font(.headline)
                            Text(devotional.reference).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .overlay {
                if marks.isEmpty {
                    ContentUnavailableView("No favorites yet", systemImage: "heart",
                                           description: Text("Tap the heart on any reading to keep it here."))
                }
            }
            .navigationTitle("Favorites")
            .toolbar { SupportToolbar() }
        }
    }
}
