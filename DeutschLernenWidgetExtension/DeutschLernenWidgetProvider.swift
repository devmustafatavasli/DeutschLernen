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
        let entry = Entry(date: Date(), entry: fetchCurrentEntry())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        // Lowest frequency: .never means only update when explicitly reloaded (via NextEntryIntent).
        let entry = Entry(date: Date(), entry: fetchCurrentEntry())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func fetchCurrentEntry() -> Entry? {
        do {
            let container = try ModelContainer(for: Entry.self, configurations: ModelConfiguration(schema: Schema([Entry.self]), isStoredInMemoryOnly: false, groupContainer: .identifier(DataStore.appGroupID)))
            let context = ModelContext(container)
            let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
            let entries = try context.fetch(descriptor)

            guard !entries.isEmpty else { return nil }

            let defaults = UserDefaults(suiteName: DataStore.appGroupID)
            let index = defaults?.integer(forKey: "widgetEntryIndex") ?? 0
            return entries[index % entries.count]
        } catch {
            return nil
        }
    }
}
