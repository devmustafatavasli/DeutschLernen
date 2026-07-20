import SwiftUI
import SwiftData

struct TestView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Entry.createdAt) private var entries: [Entry]
    @State private var currentEntry: Entry?
    @State private var isGermanRevealed = false

    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "Henüz Kayıt Bulunamadı",
                        systemImage: "text.bubble",
                        description: Text("Önce kayıt ekleyin")
                    )
                } else if let current = currentEntry {
                    ZStack {
                        CardDeckView(
                            items: [current],
                            maxVisible: 1,
                            cardContent: { entry in
                                testCard(entry)
                            },
                            interpretDrag: { translation in
                                let absH = abs(translation.height)
                                let absW = abs(translation.width)
                                if absW > 100 && absW > absH {
                                    // Spec: sağa = doğru, sola = yanlış.
                                    return translation.width > 0 ? .right : .left
                                }
                                return nil
                            },
                            onSwipe: { entry, direction in
                                // Doğru/yanlış yanıt kaydı ve sonraki kaydı hemen yükle.
                                let correct = direction == .right
                                entry.recordGrade(correct: correct)
                                try? modelContext.save()
                                isGermanRevealed = false
                                currentEntry = LeitnerScheduler.weightedNextEntry(excluding: entry, from: entries)
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
                } else {
                    Text("Yükleniyor...")
                        .onAppear { pickNextEntry() }
                }
            }
            .navigationTitle("Test")
        }
        .onAppear {
            if currentEntry == nil {
                pickNextEntry()
            }
        }
    }

    private func testCard(_ entry: Entry) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xl) {
            Text(entry.turkish)
                .font(AppTypography.title2)
                .foregroundStyle(AppColor.textPrimary)

            if isGermanRevealed {
                Text(entry.german)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.textSecondary)
            } else {
                Text("Almancasını düşün, sonra dokun")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.textTertiary)
            }

            Spacer()

            HStack(spacing: AppSpacing.md) {
                Label("✓ Doğru: sağa", systemImage: "")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.success)
                Spacer()
                Label("✗ Yanlış: sola", systemImage: "")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.error)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.lg)
        .modifier(CardBackground())
        .onTapGesture {
            withAnimation { isGermanRevealed.toggle() }
        }
    }

    private func pickNextEntry() {
        currentEntry = LeitnerScheduler.weightedNextEntry(excluding: nil, from: entries)
    }
}
