import SwiftUI
import SwiftData

struct EntriesCardStackView: View {
    @Query(sort: \Entry.createdAt, order: .reverse) private var entries: [Entry]
    @State private var rotation: Int = 0

    var body: some View {
        Group {
            if entries.isEmpty {
                ContentUnavailableView(
                    "Henüz Kayıt Bulunamadı",
                    systemImage: "text.bubble",
                    description: Text("Action Button veya Elle İlk İfadeni Yakala")
                )
            } else {
                let visibleEntries = Array(entries.indices.prefix(3).map { (entries[($0 + rotation) % entries.count]) })

                ZStack {
                    CardDeckView(
                        items: visibleEntries,
                        maxVisible: 3,
                        cardContent: { entry in
                            EntryCard(entry: entry)
                        },
                        interpretDrag: { translation in
                            abs(translation.height) > 100 && abs(translation.height) > abs(translation.width) && translation.height < 0 ? .up : nil
                        },
                        onSwipe: { _, direction in
                            if direction == .up {
                                rotation = (rotation + 1) % entries.count
                            }
                        },
                        cardColor: { entry in
                            if let idx = entries.firstIndex(where: { $0.persistentModelID == entry.persistentModelID }) {
                                CardColor.forIndex(idx)
                            } else {
                                .red
                            }
                        }
                    )
                }
                .padding(16)
            }
        }
    }
}
