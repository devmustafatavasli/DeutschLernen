import SwiftUI
import SwiftData

struct EntriesCardStackView: View {
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
                ScrollStackedCardView(
                    items: entries,
                    cardContent: { entry in
                        EntryCard(entry: entry)
                    },
                    cardColor: { index in
                        CardColor.forIndex(index).background()
                    }
                )
            }
        }
    }
}
