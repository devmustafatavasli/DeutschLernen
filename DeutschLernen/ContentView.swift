import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var formMode: EntryFormMode?

    var body: some View {
        NavigationStack {
            EntriesListView()
                .navigationTitle("Kayıtlar")
                .navigationDestination(for: Entry.self) { entry in
                    CardDetailView(entry: entry)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: { formMode = .create }) {
                            Label("Ekle", systemImage: "plus")
                        }
                    }
                }
                .sheet(item: $formMode) { mode in
                    AddEditEntryForm(mode: mode)
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
