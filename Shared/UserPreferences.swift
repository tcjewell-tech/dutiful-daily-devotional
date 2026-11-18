import Foundation

/// The only two values shared with the widget (App Group defaults). Everything else stays app-private.
enum UserPreferences {
    static let selectedTraditionKey = "selectedTradition"
    static let discreetLockScreenKey = "discreetLockScreen"

    /// shortcut: falls back to standard defaults if the App Group is not provisioned, so the app still works
    /// but the widget cannot see the choice; fix the signing/App Group setup rather than this line.
    static let defaults = UserDefaults(suiteName: AppConstants.appGroupID) ?? .standard

    static var selectedTradition: Tradition? {
        defaults.string(forKey: selectedTraditionKey).flatMap(Tradition.init(rawValue:))
    }

    /// Discreet lock screen is on until the user turns it off.
    static var discreetLockScreen: Bool {
        defaults.object(forKey: discreetLockScreenKey) as? Bool ?? true
    }
}
