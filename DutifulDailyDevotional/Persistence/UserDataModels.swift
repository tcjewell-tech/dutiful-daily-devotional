import Foundation
import SwiftData

/// App-private (not in the App Group); the widget never sees these.
@Model
final class FavoriteMark {
    @Attribute(.unique) var devotionalID: String
    var createdAt: Date

    init(devotionalID: String, createdAt: Date = .now) {
        self.devotionalID = devotionalID
        self.createdAt = createdAt
    }
}

@Model
final class JournalNote {
    @Attribute(.unique) var devotionalID: String
    var text: String
    var updatedAt: Date

    init(devotionalID: String, text: String, updatedAt: Date = .now) {
        self.devotionalID = devotionalID
        self.text = text
        self.updatedAt = updatedAt
    }
}
