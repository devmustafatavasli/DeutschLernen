import WidgetKit
import SwiftUI

struct DeutschLernenWidgetEntryView: View {
    var entry: DeutschLernenWidgetProvider.Entry

    var body: some View {
        if let entry = entry.entry {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text(entry.turkish)
                    .font(AppTypography.title3)
                    .foregroundStyle(AppColor.textPrimary)
                    .lineLimit(3)

                Text(entry.german)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.textSecondary)
                    .lineLimit(3)

                Spacer()

                Button(intent: NextEntryIntent()) {
                    Text("Sonraki")
                        .font(AppTypography.captionEmphasis)
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.sm)
                .background(AppColor.primary)
                .cornerRadius(AppSpacing.cornerSmall)
                .padding(.top, AppSpacing.md)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(AppSpacing.lg)
            .background(AppColor.surface)
        } else {
            VStack(alignment: .center, spacing: AppSpacing.md) {
                Text("Kayıt Bulunamadı")
                    .font(AppTypography.title3)
                    .foregroundStyle(AppColor.textPrimary)
                Text("Önce bir kayıt ekleyin")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.textSecondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.surface)
        }
    }
}

struct DeutschLernenWidget: Widget {
    let kind: String = "DeutschLernenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeutschLernenWidgetProvider()) { entry in
            DeutschLernenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Deutsch Lernen")
        .description("Almanca ifadeleri hatırlat.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
