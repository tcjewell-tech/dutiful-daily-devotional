import Foundation

/// The only two values shared with the widget (App Group defaults). Everything else stays app-private.
enum UserPreferences {
    static let selectedTraditionKey = "selectedTradition"
    static let discreetLockScreenKey = "discreetLockScreen"

    /// shortcut: the suite is nil only for an invalid name, not a missing App Group entitlement, so this catches
    /// a bad `appGroupID` but not unprovisioned signing (then the widget silently can't see the choice).
    static let defaults: UserDefaults = {
        if let suite = UserDefaults(suiteName: AppConstants.appGroupID) { return suite }
        assertionFailure("App Group suite unavailable")
        return .standard
    }()

    static var selectedTradition: Tradition? {
        defaults.string(forKey: selectedTraditionKey).flatMap(Tradition.init(rawValue:))
    }

    /// Discreet lock screen is on until the user turns it off.
    static var discreetLockScreen: Bool {
        defaults.object(forKey: discreetLockScreenKey) as? Bool ?? true
    }
}
