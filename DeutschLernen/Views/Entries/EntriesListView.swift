import SwiftUI
import SwiftData

struct EntriesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Entry.createdAt, order: .reverse) private var entries: [Entry]

    var body: some View {
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
                        NavigationLink(value: entry) {
                            EntryCard(entry: entry)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(.plain)
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
