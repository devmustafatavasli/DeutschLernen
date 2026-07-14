import WidgetKit
import SwiftUI
import SwiftData

struct DeutschLernenWidgetEntry: TimelineEntry {
    let date: Date
    let entry: Entry?
}

struct DeutschLernenWidgetProvider: TimelineProvider {
    typealias Entry = DeutschLernenWidgetEntry

    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(), entry: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = Entry(date: Date(), entry: fetchRandomEntry())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [Entry] = []
        let now = Date()

        for offset in 0..<4 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: offset * 6, to: now) ?? now
            entries.append(Entry(date: entryDate, entry: fetchRandomEntry()))
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    private func fetchRandomEntry() -> Entry? {
        guard let container = try? ModelContainer(for: Entry.self, configurations: ModelConfiguration(schema: Schema([Entry.self]), isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.devmustafatavasli.DeutschLernen"))) else {
            return nil
        }
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Entry>()
        guard let entries = try? context.fetch(descriptor), !entries.isEmpty else {
            return nil
        }
        return entries.randomElement()
    }
}

struct DeutschLernenWidgetEntryView: View {
    var entry: DeutschLernenWidgetProvider.Entry

    var body: some View {
        if let entry = entry.entry {
            VStack(alignment: .leading, spacing: 12) {
                Text(entry.turkish)
                    .font(.headline.weight(.semibold))
                    .lineLimit(2)

                Text(entry.german)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemBackground))
        } else {
            VStack {
                Text("Kayıt Bulunamadı")
                    .font(.headline)
                Text("Önce bir kayıt ekleyin")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
    }
}

@main
struct DeutschLernenWidget: Widget {
    let kind: String = "DeutschLernenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeutschLernenWidgetProvider()) { entry in
            DeutschLernenWidgetEntryView(entry: entry)
                .containerBackground(.fill.secondary, for: .widget)
        }
        .configurationDisplayName("Deutsch Lernen")
        .description("Rastgele Almanca ifadeleri hatırlat.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    DeutschLernenWidget()
} timeline: {
    DeutschLernenWidgetEntry(date: Date(), entry: Entry(turkish: "Benim adım Mustafa", german: "Mein Name ist Mustafa"))
}
