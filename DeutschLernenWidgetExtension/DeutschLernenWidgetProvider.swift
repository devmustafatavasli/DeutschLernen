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
            let context = ModelContext(DataStore.container)
            let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
            let entries = try context.fetch(descriptor)

            guard !entries.isEmpty else { return nil }

            let index = DataStore.sharedDefaults.integer(forKey: "widgetEntryIndex")
            return entries[index % entries.count]
        } catch {
            return nil
        }
    }
}
