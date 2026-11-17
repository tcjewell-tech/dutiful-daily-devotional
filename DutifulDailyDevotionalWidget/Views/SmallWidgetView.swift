import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    let entry: DevotionalEntry

    var body: some View {
        if let devotional = entry.devotional {
            VStack(alignment: .leading, spacing: 6) {
                Text("Today").font(.caption).foregroundStyle(.secondary)
                Text(devotional.theme)
                    .font(.title3.bold())
                    .minimumScaleFactor(0.7)
                    .lineLimit(2)
                Spacer(minLength: 0)
                Text(devotional.reference)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        } else {
            NoSelectionView()
        }
    }
}
