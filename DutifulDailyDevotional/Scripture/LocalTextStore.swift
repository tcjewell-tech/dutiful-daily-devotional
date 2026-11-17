import Foundation

/// Spec §4.3 shape: `Texts/<source>/<work>.json`.
struct TextWork: Decodable {
    let work: String
    let divisions: [TextDivision]
}

struct TextDivision: Decodable {
    let number: Int
    let verses: [TextVerse]
}

struct TextVerse: Decodable, Identifiable {
    let number: Int
    let text: String
    var id: Int { number }
}

struct LocalTextStore {
    var bundle: Bundle = .main

    func division(for reference: SourceReference, tradition: Tradition) -> TextDivision? {
        guard let url = bundle.url(forResource: reference.work, withExtension: "json",
                                   subdirectory: "Texts/\(tradition.textDirectory)"),
              let data = try? Data(contentsOf: url),
              let work = try? JSONDecoder().decode(TextWork.self, from: data)
        else { return nil }
        return work.divisions.first { $0.number == reference.division }
    }

    /// The referenced verses joined with spaces, or nil if any of them is missing.
    func passageText(for reference: SourceReference, tradition: Tradition) -> String? {
        guard let division = division(for: reference, tradition: tradition) else { return nil }
        let verses = division.verses.filter { reference.contains(verse: $0.number) }
        guard !verses.isEmpty, reference.verses.map({ $0.count == verses.count }) ?? true else { return nil }
        return verses.map(\.text).joined(separator: " ")
    }
}
