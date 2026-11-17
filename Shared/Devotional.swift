import Foundation

struct Devotional: Hashable, Identifiable {
    let tradition: Tradition
    let day: Int
    let theme: String
    let reference: String
    let passageText: String
    let reflection: String
    let studyPrompts: [String]

    /// Keys favorites and journal notes, e.g. "christian-1".
    var id: String { "\(tradition.rawValue)-\(day)" }

    var shareText: String { "\(passageText)\n— \(reference)" }
}

/// On-disk shape of `Shared/Resources/Devotionals/<tradition>.json`.
struct DevotionalFile: Decodable {
    struct Entry: Decodable {
        let day: Int
        let theme: String
        let reference: String
        let passageText: String
        let reflection: String
        let studyPrompts: [String]
    }

    let tradition: Tradition
    let entries: [Entry]
}
