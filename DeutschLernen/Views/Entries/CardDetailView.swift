import SwiftUI
import SwiftData

struct CardDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let entry: Entry
    @State private var formMode: EntryFormMode?

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xl) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Türkçe")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.textSecondary)
                Text(entry.turkish)
                    .font(AppTypography.title2)
                    .foregroundStyle(AppColor.textPrimary)
            }

            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Almanca")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.textSecondary)
                Text(entry.german)
                    .font(AppTypography.title2)
                    .foregroundStyle(AppColor.textPrimary)
            }

            Spacer()

            HStack(spacing: AppSpacing.md) {
                Button(action: { entry.isFavorite.toggle(); try? modelContext.save() }) {
                    Label(
                        entry.isFavorite ? "Favorilerden çıkar" : "Favorilere ekle",
                        systemImage: entry.isFavorite ? "heart.fill" : "heart"
                    )
                    .foregroundStyle(entry.isFavorite ? AppColor.error : AppColor.textSecondary)
                }

                Button(action: { formMode = .edit(entry) }) {
                    Label("Düzenle", systemImage: "pencil")
                        .foregroundStyle(AppColor.textSecondary)
                }

                Spacer()
            }
        }
        .padding(AppSpacing.lg)
        .modifier(CardBackground())
        .padding(AppSpacing.lg)
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $formMode) { mode in
            AddEditEntryForm(mode: mode)
        }
    }
}
