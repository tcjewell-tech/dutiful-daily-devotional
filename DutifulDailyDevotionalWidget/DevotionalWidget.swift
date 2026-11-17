import SwiftUI
import WidgetKit

struct DevotionalWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: AppConstants.widgetKind, provider: DevotionalTimelineProvider()) { entry in
            DevotionalWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .widgetURL(AppConstants.todayURL)
        }
        // Gallery name stays neutral: nothing faith-identifying.
        .configurationDisplayName("Daily Reflection")
        .description("Today's theme and passage.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])
    }
}

struct DevotionalWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: DevotionalEntry

    var body: some View {
        switch family {
        case .systemMedium: MediumWidgetView(entry: entry)
        case .accessoryRectangular: LockScreenWidgetView(entry: entry)
        default: SmallWidgetView(entry: entry)
        }
    }
}

/// Shown until a tradition has been chosen in the app.
struct NoSelectionView: View {
    var body: some View {
        Text("Open the app to choose a tradition.")
            .font(.footnote)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}
