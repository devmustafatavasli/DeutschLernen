import SwiftUI
import SwiftData

enum EntriesDisplayMode {
    case list
    case stack
}

struct EntriesView: View {
    @State private var displayMode: EntriesDisplayMode = .list
    @State private var formMode: EntryFormMode?

    var body: some View {
        NavigationStack {
            Group {
                if displayMode == .list {
                    EntriesListView()
                } else {
                    EntriesCardStackView()
                }
            }
            .navigationTitle("Kayıtlar")
            .navigationDestination(for: Entry.self) { entry in
                CardDetailView(entry: entry)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Display", selection: $displayMode) {
                        Label("List", systemImage: "list.bullet").tag(EntriesDisplayMode.list)
                        Label("Stack", systemImage: "square.stack").tag(EntriesDisplayMode.stack)
                    }
                    .pickerStyle(.segmented)
                }
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
