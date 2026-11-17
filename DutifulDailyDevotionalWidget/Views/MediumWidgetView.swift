import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    let entry: DevotionalEntry

    var body: some View {
        if let devotional = entry.devotional {
            VStack(alignment: .leading, spacing: 4) {
                Text(devotional.theme).font(.headline)
                Text(devotional.passageText)
                    .font(.subheadline)
                    .lineLimit(4)
                    .truncationMode(.tail)
                Spacer(minLength: 0)
                Text(devotional.reference).font(.caption).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        } else {
            NoSelectionView()
        }
    }
}
