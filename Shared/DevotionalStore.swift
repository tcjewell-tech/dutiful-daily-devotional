import Foundation

struct DevotionalStore {
    var bundle: Bundle = .main

    private static let cache = DevotionalCache()

    /// Entries sorted by day. Missing or malformed files are a build defect caught by tests,
    /// so at runtime they quietly yield an empty list and the UI shows "Content unavailable".
    func devotionals(for tradition: Tradition) -> [Devotional] {
        // Keyed by bundle path too, so tests with their own bundle never get .main's entries.
        let key = bundle.bundlePath + "/" + tradition.rawValue
        if let cached = Self.cache[key] { return cached }
        let loaded = load(tradition)
        // Empty means the read failed; leave it uncached so a later call can retry.
        if !loaded.isEmpty { Self.cache[key] = loaded }
        return loaded
    }

    func devotional(id: String) -> Devotional? {
        let parts = id.split(separator: "-")
        guard parts.count == 2,
              let tradition = Tradition(rawValue: String(parts[0])),
              let day = Int(parts[1])
        else { return nil }
        return devotionals(for: tradition).first { $0.day == day }
    }

    private func load(_ tradition: Tradition) -> [Devotional] {
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
}

/// Process-wide decoded files; callers may be on any thread (views, widget timeline provider).
private final class DevotionalCache: @unchecked Sendable {
    private let lock = NSLock()
    private var entries: [String: [Devotional]] = [:]

    subscript(key: String) -> [Devotional]? {
        get { lock.withLock { entries[key] } }
        set { lock.withLock { entries[key] = newValue } }
    }
}
