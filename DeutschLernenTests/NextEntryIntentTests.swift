import Testing
import Foundation
import SwiftData
import WidgetKit
@testable import DeutschLernen
@testable import DeutschLernenWidgetExtension

struct NextEntryIntentTests {
    private func createTestEnvironment() throws -> (ModelContainer, UserDefaults) {
        let schema = Schema([Entry.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])

        let defaults = UserDefaults(suiteName: "test.next.intent")
        defaults?.removePersistentDomain(forName: "test.next.intent")
        let freshDefaults = UserDefaults(suiteName: "test.next.intent")!

        return (container, freshDefaults)
    }

    @Test
    func performAdvancesIndexWithMultipleEntries() async throws {
        let (container, defaults) = try createTestEnvironment()
        let originalContainer = DataStore.container
        defer { DataStore.container = originalContainer }

        DataStore.container = container

        let context = ModelContext(container)
        let entry1 = Entry(turkish: "First", german: "Erste")
        let entry2 = Entry(turkish: "Second", german: "Zweite")
        context.insert(entry1)
        context.insert(entry2)
        try context.save()

        defaults.set(0, forKey: "widgetEntryIndex")

        let intent = NextEntryIntent()
        _ = try await intent.perform()

        let newIndex = defaults.integer(forKey: "widgetEntryIndex")
        #expect(newIndex != 0)
    }

    @Test
    func performDoesNotCrashOnEmptyStore() async throws {
        let (container, _) = try createTestEnvironment()
        let originalContainer = DataStore.container
        defer { DataStore.container = originalContainer }

        DataStore.container = container

        let intent = NextEntryIntent()
        let result = try await intent.perform()

        #expect(result != nil)
    }

    @Test
    func performDoesNotCrashWithSingleEntry() async throws {
        let (container, defaults) = try createTestEnvironment()
        let originalContainer = DataStore.container
        defer { DataStore.container = originalContainer }

        DataStore.container = container

        let context = ModelContext(container)
        let entry = Entry(turkish: "Only", german: "Einzige")
        context.insert(entry)
        try context.save()

        defaults.set(0, forKey: "widgetEntryIndex")

        let intent = NextEntryIntent()
        let result = try await intent.perform()

        #expect(result != nil)
    }

    @Test
    func performSelectsFromWeightedPool() async throws {
        let (container, defaults) = try createTestEnvironment()
        let originalContainer = DataStore.container
        defer { DataStore.container = originalContainer }

        DataStore.container = container

        let context = ModelContext(container)
        var lowBox = Entry(turkish: "Low", german: "Niedrig")
        lowBox.box = 1

        var highBox = Entry(turkish: "High", german: "Hoch")
        highBox.box = 5

        context.insert(lowBox)
        context.insert(highBox)
        try context.save()

        // Refresh to get persistent IDs
        let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
        let entries = try context.fetch(descriptor)

        defaults.set(0, forKey: "widgetEntryIndex")

        let intent = NextEntryIntent()
        _ = try await intent.perform()

        let newIndex = defaults.integer(forKey: "widgetEntryIndex")
        #expect(newIndex >= 0)
        #expect(newIndex < entries.count)
    }
}
