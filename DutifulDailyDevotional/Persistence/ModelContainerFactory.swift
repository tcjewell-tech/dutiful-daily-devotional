import Foundation
import SwiftData

enum ModelContainerFactory {
    static let shared: ModelContainer = make()

    static func make() -> ModelContainer {
        let schema = Schema([FavoriteMark.self, JournalNote.self])
        if let url = try? storeURL(),
           let container = try? ModelContainer(
               for: schema,
               configurations: ModelConfiguration(schema: schema, url: url, cloudKitDatabase: .none)) {
            return container
        }
        // The on-disk store could not open (e.g. disk full). Keep the app usable; notes last until quit.
        do {
            return try ModelContainer(
                for: schema,
                configurations: ModelConfiguration(schema: schema, isStoredInMemoryOnly: true, cloudKitDatabase: .none))
        } catch {
            fatalError("SwiftData schema is invalid: \(error)")
        }
    }

    /// Application Support/UserData: file protection `.complete` (new files inherit it) and excluded from backups.
    private static func storeURL() throws -> URL {
        let fileManager = FileManager.default
        var directory = try fileManager
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("UserData", isDirectory: true)
        let protection: [FileAttributeKey: Any] = [.protectionKey: FileProtectionType.complete]
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: protection)
        try fileManager.setAttributes(protection, ofItemAtPath: directory.path)
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try directory.setResourceValues(values)
        return directory.appendingPathComponent("UserData.store")
    }
}
