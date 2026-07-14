import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]
    @State private var formMode: EntryFormMode?

    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "Henüz Kayıt Bulunamadı",
                        systemImage: "text.bubble",
                        description: Text("Action Button veya Elle İlk İfadeni Yakala")
                    )
                } else {
                    List {
                        ForEach(entries) { entry in
                            EntryCard(entry: entry)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                        .onDelete(perform: deleteEntries)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Entries")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { formMode = .create }) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }
            .sheet(item: $formMode) { mode in
                AddEditEntryForm(mode: mode)
            }
        }
    }

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
