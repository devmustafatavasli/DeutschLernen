import AppIntents
import SwiftData
import WidgetKit

struct NextEntryIntent: AppIntent {
    static var title: LocalizedStringResource = "Next Entry"
    static var description: IntentDescription = IntentDescription("Sonraki ifadeyi göster")

    func perform() async throws -> some IntentResult {
        do {
            let container = try ModelContainer(
                for: Entry.self,
                configurations: ModelConfiguration(
                    schema: Schema([Entry.self]),
                    isStoredInMemoryOnly: false,
                    groupContainer: .identifier("group.com.devmustafatavasli.DeutschLernen")
                )
            )
            let context = ModelContext(container)
            let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
            let entries = try context.fetch(descriptor)

            guard !entries.isEmpty else {
                return .result()
            }

            let defaults = UserDefaults(suiteName: "group.com.devmustafatavasli.DeutschLernen")
            let currentIndex = defaults?.integer(forKey: "widgetEntryIndex") ?? 0
            let currentEntry = entries[currentIndex % entries.count]

            // Get next entry using Leitner scheduler
            if let nextEntry = LeitnerScheduler.weightedNextEntry(excluding: currentEntry, from: entries) {
                if let nextIndex = entries.firstIndex(where: { $0.persistentModelID == nextEntry.persistentModelID }) {
                    defaults?.set(nextIndex, forKey: "widgetEntryIndex")
                }
            }

            // Reload all widget timelines
            WidgetCenter.shared.reloadTimelines(ofKind: "DeutschLernenWidget")
        } catch {
            return .result()
        }

        return .result()
    }
}
