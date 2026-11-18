import SwiftData
import SwiftUI

@main
struct DutifulDailyDevotionalApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(ModelContainerFactory.shared)
    }
}
