import SwiftUI
import WidgetKit

/// Discreet mode (default) shows only the theme: no reference, no tradition.
struct LockScreenWidgetView: View {
    let entry: DevotionalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let devotional = entry.devotional {
                if entry.discreet {
                    Text("Today").font(.caption)
                    Text(devotional.theme).font(.headline).lineLimit(1)
                } else {
                    Text(devotional.theme).font(.headline).lineLimit(1)
                    Text(devotional.reference).font(.caption).lineLimit(1)
                }
            } else {
                Text("Daily reflection").font(.headline)
            }
        }
        .privacySensitive()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
