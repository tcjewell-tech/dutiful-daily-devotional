import Foundation

struct DevotionalStore {
    var bundle: Bundle = .main

    /// Entries sorted by day. Missing or malformed files are a build defect caught by tests,
    /// so at runtime they quietly yield an empty list and the UI shows "Content unavailable".
    func devotionals(for tradition: Tradition) -> [Devotional] {
        guard let url = bundle.url(forResource: tradition.rawValue, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let file = try? JSONDecoder().decode(DevotionalFile.self, from: data),
              file.tradition == tradition
        else { return [] }

        return file.entries
            .sorted { $0.day < $1.day }
            .map {
                Devotional(tradition: tradition, day: $0.day, theme: $0.theme, reference: $0.reference,
                           passageText: $0.passageText, reflection: $0.reflection, studyPrompts: $0.studyPrompts)
            }
    }

    func devotional(id: String) -> Devotional? {
        let parts = id.split(separator: "-")
        guard parts.count == 2,
              let tradition = Tradition(rawValue: String(parts[0])),
              let day = Int(parts[1])
        else { return nil }
        return devotionals(for: tradition).first { $0.day == day }
    }
}
