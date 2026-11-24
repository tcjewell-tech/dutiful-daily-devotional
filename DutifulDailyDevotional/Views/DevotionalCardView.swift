import SwiftData
import SwiftUI

struct DevotionalCardView: View {
    let devotional: Devotional

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(devotional.theme)
                .font(.title.bold())
                .accessibilityAddTraits(.isHeader)
            VStack(alignment: .leading, spacing: 6) {
                Text(devotional.passageText).font(.title3)
                Text(devotional.reference).font(.subheadline).foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("devotionalPassage")
            Divider()
            Text(devotional.reflection)
        }
    }
}

struct FavoriteButton: View {
    let devotionalID: String
    @Environment(\.modelContext) private var context
    @Query private var marks: [FavoriteMark]

    init(devotionalID: String) {
        self.devotionalID = devotionalID
        _marks = Query(filter: #Predicate<FavoriteMark> { $0.devotionalID == devotionalID })
    }

    var body: some View {
        let isFavorite = !marks.isEmpty
        Button {
            if isFavorite {
                for mark in marks { context.delete(mark) }
            } else {
                context.insert(FavoriteMark(devotionalID: devotionalID))
            }
        } label: {
            Label(isFavorite ? "Remove from favorites" : "Add to favorites",
                  systemImage: isFavorite ? "heart.fill" : "heart")
        }
        .buttonStyle(.bordered)
    }
}
