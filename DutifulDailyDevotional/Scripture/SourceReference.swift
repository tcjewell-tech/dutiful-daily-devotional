import Foundation

/// A parsed devotional reference, pointing at one file in `Texts/<tradition.textDirectory>/`.
struct SourceReference: Equatable {
    /// File name of the work: a book ("1 John"), a surah number ("2"), "Meditations", "Letters" or "Enchiridion".
    let work: String
    /// Chapter, surah, book of Meditations, letter number, or Enchiridion chapter.
    let division: Int
    /// `nil` means the whole division (Enchiridion chapters have no verse numbers).
    let verses: ClosedRange<Int>?

    func contains(verse: Int) -> Bool {
        verses?.contains(verse) ?? true
    }

    static func parse(_ reference: String, tradition: Tradition) -> SourceReference? {
        let text = reference.trimmingCharacters(in: .whitespaces)
        switch tradition {
        case .christian, .jewish:
            guard let match = text.wholeMatch(of: #/(.+?) (\d+):(\d+)(?:-(\d+))?/#) else { return nil }
            return make(String(match.1), match.2, match.3, match.4)
        case .muslim:
            guard let match = text.wholeMatch(of: #/Qur['’]an (\d+):(\d+)(?:-(\d+))?/#),
                  let surah = Int(match.1), (1...114).contains(surah)
            else { return nil }
            return make(String(surah), match.1, match.2, match.3)
        case .humanist:
            if let match = text.wholeMatch(of: #/Enchiridion (\d+)/#) {
                guard let chapter = Int(match.1), chapter > 0 else { return nil }
                return SourceReference(work: "Enchiridion", division: chapter, verses: nil)
            }
            guard let match = text.wholeMatch(of: #/(Meditations|Seneca, Letters) (\d+)\.(\d+)(?:-(\d+))?/#)
            else { return nil }
            return make(match.1 == "Meditations" ? "Meditations" : "Letters", match.2, match.3, match.4)
        }
    }

    private static func make(_ work: String, _ division: Substring, _ first: Substring, _ last: Substring?) -> SourceReference? {
        guard let division = Int(division), let first = Int(first) else { return nil }
        let end = last.flatMap { Int($0) } ?? first
        guard division > 0, first > 0, end >= first else { return nil }
        return SourceReference(work: work, division: division, verses: first...end)
    }
}
