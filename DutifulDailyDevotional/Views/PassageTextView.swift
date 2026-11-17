import SwiftUI

/// The whole chapter / surah / section with the day's verses highlighted.
/// Falls back to the passage alone when the reference can't be parsed or the full text isn't bundled.
struct PassageTextView: View {
    let devotional: Devotional

    var body: some View {
        let reference = SourceReference.parse(devotional.reference, tradition: devotional.tradition)
        if let reference,
           let division = LocalTextStore().division(for: reference, tradition: devotional.tradition) {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(division.verses) { verse in
                    let highlighted = reference.contains(verse: verse.number)
                    (Text("\(verse.number) ").font(.caption).foregroundColor(.secondary) + Text(verse.text))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(highlighted ? 6 : 0)
                        .background(highlighted ? Color.accentColor.opacity(0.15) : Color.clear,
                                    in: RoundedRectangle(cornerRadius: 6))
                        .accessibilityElement(children: .combine)
                        .accessibilityHint(highlighted ? Text("Today's passage") : Text(""))
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 6) {
                Text(devotional.passageText)
                Text(devotional.reference).font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }
}
