import Foundation

enum Tradition: String, CaseIterable, Codable, Identifiable {
    case christian, jewish, muslim, humanist

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .christian: "Christian"
        case .jewish: "Jewish"
        case .muslim: "Muslim"
        case .humanist: "Humanist"
        }
    }

    var sourceName: String {
        switch self {
        case .christian: "World English Bible"
        case .jewish: "JPS 1917 Tanakh"
        case .muslim: "The Qur'an, Pickthall translation"
        case .humanist: "Stoic writings: Marcus Aurelius, Epictetus, Seneca"
        }
    }

    var sourceAttribution: String {
        switch self {
        case .christian:
            "Scripture from the World English Bible (WEB), which is in the public domain."
        case .jewish:
            "Scripture from The Holy Scriptures According to the Masoretic Text (Jewish Publication Society, 1917), which is in the public domain. Verse numbers follow the Hebrew text."
        case .muslim:
            "Qur'an text from The Meaning of the Glorious Koran, translated by Marmaduke Pickthall (1930), in the public domain in the United States."
        case .humanist:
            "Marcus Aurelius, Meditations, and Epictetus, Enchiridion, translated by George Long; Seneca, Moral Letters to Lucilius, translated by Richard M. Gummere. All in the public domain."
        }
    }

    /// Folder under `Texts/` holding this tradition's full source texts.
    var textDirectory: String {
        switch self {
        case .christian: "web"
        case .jewish: "jps1917"
        case .muslim: "pickthall"
        case .humanist: "stoics"
        }
    }
}
