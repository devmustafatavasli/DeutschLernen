import Testing
import Foundation
import SwiftData
@testable import DeutschLernen

struct AddEntryIntentTests {
    private func createTestContainer() throws -> ModelContainer {
        let schema = Schema([Entry.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try ModelContainer(for: schema, configurations: [config])
    }

    @Test
    func performInsertsEntryIntoStore() async throws {
        let container = try createTestContainer()
        let original = DataStore.container
        defer { DataStore.container = original }

        DataStore.container = container

        let intent = AddEntryIntent(turkish: "Test Turkish", german: "Test German")
        _ = try await intent.perform()

        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)

        #expect(fetched.count == 1)
        #expect(fetched[0].turkish == "Test Turkish")
        #expect(fetched[0].german == "Test German")
    }

    @Test
    func performInsertsMultipleEntries() async throws {
        let container = try createTestContainer()
        let original = DataStore.container
        defer { DataStore.container = original }

        DataStore.container = container

        let intent1 = AddEntryIntent(turkish: "First", german: "Erste")
        let intent2 = AddEntryIntent(turkish: "Second", german: "Zweite")

        _ = try await intent1.perform()
        _ = try await intent2.perform()

        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)

        #expect(fetched.count == 2)
    }

    @Test
    func performSetsDefaultBoxTo1() async throws {
        let container = try createTestContainer()
        let original = DataStore.container
        defer { DataStore.container = original }

        DataStore.container = container

        let intent = AddEntryIntent(turkish: "New", german: "Neu")
        _ = try await intent.perform()

        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)

        #expect(fetched[0].box == 1)
    }
}
