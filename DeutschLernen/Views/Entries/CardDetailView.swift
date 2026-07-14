import SwiftUI
import SwiftData

struct CardDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let entry: Entry
    @State private var formMode: EntryFormMode?

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Türkçe")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(entry.turkish)
                    .font(.title2.weight(.semibold))
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Almanca")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(entry.german)
                    .font(.title2.weight(.semibold))
            }

            Spacer()

            HStack(spacing: 12) {
                Button(action: { entry.isFavorite.toggle(); try? modelContext.save() }) {
                    Label("", systemImage: entry.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(entry.isFavorite ? .red : .gray)
                }

                Button(action: { formMode = .edit(entry) }) {
                    Label("", systemImage: "pencil")
                }

                Spacer()
            }
        }
        .padding(24)
        .modifier(CardBackground())
        .padding(16)
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $formMode) { mode in
            AddEditEntryForm(mode: mode)
        }
    }
}
