import AppIntents
import SwiftData
import WidgetKit

struct NextEntryIntent: AppIntent {
    static var title: LocalizedStringResource = "Next Entry"
    static var description: IntentDescription = IntentDescription("Sonraki ifadeyi göster")

    func perform() async throws -> some IntentResult {
        do {
            let context = ModelContext(DataStore.container)
            let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
            let entries = try context.fetch(descriptor)

            guard !entries.isEmpty else { return .result() }

            let currentIndex = DataStore.sharedDefaults.integer(forKey: "widgetEntryIndex")
            let currentEntry = entries[currentIndex % entries.count]

            if let nextEntry = LeitnerScheduler.weightedNextEntry(excluding: currentEntry, from: entries) {
                if let nextIndex = entries.firstIndex(where: { $0.persistentModelID == nextEntry.persistentModelID }) {
                    DataStore.sharedDefaults.set(nextIndex, forKey: "widgetEntryIndex")
                }
            }

            WidgetCenter.shared.reloadTimelines(ofKind: "DeutschLernenWidget")
        } catch {
            return .result()
        }

        return .result()
    }
}
