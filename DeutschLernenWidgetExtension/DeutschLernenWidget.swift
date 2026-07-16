import WidgetKit
import SwiftUI

struct DeutschLernenWidgetEntryView: View {
    var entry: DeutschLernenWidgetProvider.Entry

    var body: some View {
        if let entry = entry.entry {
            VStack(alignment: .leading, spacing: 12) {
                Text(entry.turkish)
                    .font(.headline.weight(.semibold))
                    .lineLimit(3)

                Text(entry.german)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                Spacer()

                Button(intent: NextEntryIntent()) {
                    Text("Sonraki")
                        .font(.caption.weight(.semibold))
                }
                .buttonStyle(.plain)
                .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .background(.fill.secondary)
        } else {
            VStack(alignment: .center, spacing: 8) {
                Text("Kayıt Bulunamadı")
                    .font(.headline)
                Text("Önce bir kayıt ekleyin")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.fill.secondary)
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
