import SwiftData
import SwiftUI

struct StudyView: View {
    let devotional: Devotional

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(devotional.theme).font(.title2.bold()).accessibilityAddTraits(.isHeader)
                    Text(devotional.reference).font(.subheadline).foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Questions for reflection").font(.headline).accessibilityAddTraits(.isHeader)
                    ForEach(Array(devotional.studyPrompts.enumerated()), id: \.offset) { index, prompt in
                        Text("\(index + 1). \(prompt)")
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Private note").font(.headline).accessibilityAddTraits(.isHeader)
                    JournalEditor(devotionalID: devotional.id)
                    Text("Stored only on this device. Never shown in the widget.")
                        .font(.footnote).foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("In context").font(.headline).accessibilityAddTraits(.isHeader)
                    PassageTextView(devotional: devotional)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Study")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct JournalEditor: View {
    let devotionalID: String
    @Environment(\.modelContext) private var context
    @Query private var notes: [JournalNote]
    @State private var text = ""

    init(devotionalID: String) {
        self.devotionalID = devotionalID
        _notes = Query(filter: #Predicate<JournalNote> { $0.devotionalID == devotionalID })
    }

    var body: some View {
        TextEditor(text: $text)
            .frame(minHeight: 160)
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary.opacity(0.4)))
            .accessibilityLabel("Private note")
            .onAppear { text = notes.first?.text ?? "" }
            .onChange(of: text) { save() }
    }

    private func save() {
        if let note = notes.first {
            guard note.text != text else { return }
            note.text = text
            note.updatedAt = .now
        } else if !text.isEmpty {
            context.insert(JournalNote(devotionalID: devotionalID, text: text))
        }
    }
}
