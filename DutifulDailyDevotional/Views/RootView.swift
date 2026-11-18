import SwiftUI
import WidgetKit

struct RootView: View {
    @AppStorage(UserPreferences.selectedTraditionKey, store: UserPreferences.defaults)
    private var traditionRaw = ""
    @AppStorage(UserPreferences.discreetLockScreenKey, store: UserPreferences.defaults)
    private var discreetLockScreen = true
    @State private var selectedTab = AppTab.today

    enum AppTab { case today, archive, favorites, settings }

    var body: some View {
        Group {
            if let tradition = Tradition(rawValue: traditionRaw) {
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
                    SettingsView()
                        .tabItem { Label("Settings", systemImage: "gearshape") }
                        .tag(AppTab.settings)
                }
            } else {
                OnboardingView { traditionRaw = $0.rawValue }
            }
        }
        .onOpenURL { url in
            if DeepLink(url: url) == .today { selectedTab = .today }
        }
        .onChange(of: traditionRaw) { WidgetCenter.shared.reloadAllTimelines() }
        .onChange(of: discreetLockScreen) { WidgetCenter.shared.reloadAllTimelines() }
    }
}
