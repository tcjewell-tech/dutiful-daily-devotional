import Foundation

enum AppConstants {
    static let appGroupID = "group.com.example.dutifuldailydevotional"
    static let urlScheme = "dutifuldevotional"
    static let widgetKind = "DutifulDailyDevotionalWidget"
    /// Opened by every widget family; handled by `DeepLink`.
    static let todayURL = URL(string: "\(urlScheme)://today")
}
