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
                    ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                        NavigationLink(value: entry) {
                            EntryCard(entry: entry)
                                .background(CardColor.forIndex(index).background())
                                .cornerRadius(AppSpacing.cornerLarge)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: AppSpacing.sm, leading: AppSpacing.lg, bottom: AppSpacing.sm, trailing: AppSpacing.lg))
                    }
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(AppColor.background)
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
