import SwiftUI

struct EntryCard: View {
    let entry: Entry
    var isGermanRevealed: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.lg)
        .modifier(CardBackground())
    }
}
