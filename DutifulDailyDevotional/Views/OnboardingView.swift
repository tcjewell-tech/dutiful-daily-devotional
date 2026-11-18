import SwiftUI

struct OnboardingView: View {
    let onChoose: (Tradition) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Dutiful Daily Devotional")
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
                Text("Choose the tradition for your daily reading. You can change it any time in Settings.")

                ForEach(Tradition.allCases) { tradition in
                    Button { onChoose(tradition) } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(tradition.displayName).font(.headline)
                            Text(tradition.sourceName).font(.footnote).foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 6)
                    }
                    .buttonStyle(.bordered)
                }

                Text("Works fully offline. Nothing you read or write here leaves your device.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}
