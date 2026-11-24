import SwiftUI
import WidgetKit

struct RootView: View {
    // The one owner of the preferences; Settings edits this same instance, so Today follows at once.
    @State private var preferences = AppPreferences()
    @State private var selectedTab = AppTab.today

    enum AppTab { case today, archive, favorites, settings }

    var body: some View {
        Group {
            if let tradition = preferences.selectedTradition {
                TabView(selection: $selectedTab) {
                    TodayView(tradition: tradition)
                        .tabItem { Label("Today", systemImage: "sun.max") }
                        .tag(AppTab.today)
                    ArchiveView(tradition: tradition)
                        .tabItem { Label("Archive", systemImage: "calendar") }
                        .tag(AppTab.archive)
                    FavoritesView()
                        .tabItem { Label("Favorites", systemImage: "heart") }
                        .tag(AppTab.favorites)
                    SettingsView(preferences: preferences)
                        .tabItem { Label("Settings", systemImage: "gearshape") }
                        .tag(AppTab.settings)
                }
            } else {
                OnboardingView { preferences.selectedTradition = $0 }
            }
        }
        .onOpenURL { url in
            if DeepLink(url: url) == .today { selectedTab = .today }
        }
        .onChange(of: preferences.selectedTradition) { WidgetCenter.shared.reloadAllTimelines() }
        .onChange(of: preferences.discreetLockScreen) { WidgetCenter.shared.reloadAllTimelines() }
    }
}
