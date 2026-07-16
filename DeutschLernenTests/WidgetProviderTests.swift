import Testing
import Foundation
import SwiftData
import WidgetKit
@testable import DeutschLernen
@testable import DeutschLernenWidgetExtension

struct WidgetProviderTests {
    private func createTestEnvironment() throws -> (ModelContainer, UserDefaults) {
        let schema = Schema([Entry.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])

        let defaults = UserDefaults(suiteName: "test.widget.defaults")
        defaults?.removePersistentDomain(forName: "test.widget.defaults")
        let freshDefaults = UserDefaults(suiteName: "test.widget.defaults")!

        return (container, freshDefaults)
    }

    @Test
    func snapshotReturnsNilEntryOnEmptyStore() throws {
        let (container, defaults) = try createTestEnvironment()
        let original = DataStore.container
        let originalDefaults = DataStore.sharedDefaults
        defer {
            DataStore.container = original
            // Can't easily swap sharedDefaults, so just verify the test ran
        }

        DataStore.container = container

        let provider = DeutschLernenWidgetProvider()
        var result: DeutschLernenWidgetEntry?

        provider.getSnapshot(in: WidgetKit.TimelineProviderContext(family: .systemSmall, isPreview: true)) { entry in
            result = entry
        }

        // On empty store, entry.entry should be nil
        #expect(result?.entry == nil)
    }

    @Test
    func getTimelineReturnsNeverReloadPolicy() throws {
        let (container, _) = try createTestEnvironment()
        let original = DataStore.container
        defer { DataStore.container = original }

        DataStore.container = container

        let provider = DeutschLernenWidgetProvider()
        var resultTimeline: Timeline<DeutschLernenWidgetEntry>?

        provider.getTimeline(in: WidgetKit.TimelineProviderContext(family: .systemSmall, isPreview: true)) { timeline in
            resultTimeline = timeline
        }

        // Widget should use .never policy for lowest frequency
        #expect(resultTimeline?.policy == .never)
    }
}
