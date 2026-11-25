import Foundation
import Observation

/// The only two values shared with the widget (App Group defaults). Everything else stays app-private.
enum UserPreferences {
    static let selectedTraditionKey = "selectedTradition"
    static let discreetLockScreenKey = "discreetLockScreen"

    /// shortcut: Release builds fall back to standard defaults if the App Group is missing, so the app still works but
    /// the widget can't see the choice. Debug builds stop instead, so a signing or entitlement mistake shows up early.
    static let defaults: UserDefaults = {
        #if DEBUG
        // Unit tests run in an unsigned host app that may have no container; they use their own suites.
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil,
           FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppConstants.appGroupID) == nil {
            assertionFailure("App Group container unavailable: check the App Group entitlement and signing")
        }
        #endif
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

/// The app's one live copy of the shared preferences. Views that read it re-render when it changes,
/// and every change is written straight through to the App Group defaults the widget reads.
@Observable
final class AppPreferences {
    private let store: UserDefaults

    var selectedTradition: Tradition? {
        didSet { store.set(selectedTradition?.rawValue, forKey: UserPreferences.selectedTraditionKey) }
    }

    var discreetLockScreen: Bool {
        didSet { store.set(discreetLockScreen, forKey: UserPreferences.discreetLockScreenKey) }
    }

    /// App-only (the widget never reads it). Setting it back to false replays the walkthrough.
    var hasSeenOrientation: Bool {
        didSet { store.set(hasSeenOrientation, forKey: "hasSeenOrientation") }
    }

    init(store: UserDefaults = UserPreferences.defaults) {
        self.store = store
        hasSeenOrientation = store.bool(forKey: "hasSeenOrientation")
        selectedTradition = store.string(forKey: UserPreferences.selectedTraditionKey).flatMap(Tradition.init(rawValue:))
        discreetLockScreen = store.object(forKey: UserPreferences.discreetLockScreenKey) as? Bool ?? true
    }
}
