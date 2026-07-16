import Testing
import Foundation
import SwiftData
@testable import DeutschLernen

struct DataStoreCRUDTests {
    private func createTestContainer() throws -> ModelContainer {
        let schema = Schema([Entry.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try ModelContainer(for: schema, configurations: [config])
    }

    @Test
    func insertsAndFetchesEntry() throws {
        let container = try createTestContainer()
        let context = ModelContext(container)

        let entry = Entry(turkish: "Merhabalar", german: "Hallo zusammen")
        context.insert(entry)
        try context.save()

        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)
        #expect(fetched.count == 1)
        #expect(fetched[0].turkish == "Merhabalar")
    }

    @Test
    func fetchesEntriesSortedByCreatedAt() throws {
        let container = try createTestContainer()
        let context = ModelContext(container)

        let entry1 = Entry(turkish: "First", german: "Erste")
        let entry2 = Entry(turkish: "Second", german: "Zweite")
        context.insert(entry1)
        context.insert(entry2)
        try context.save()

        let descriptor = FetchDescriptor<Entry>(sortBy: [SortDescriptor(\.createdAt)])
        let fetched = try context.fetch(descriptor)
        #expect(fetched.count == 2)
        #expect(fetched[0].turkish == "First")
        #expect(fetched[1].turkish == "Second")
    }

    @Test
    func deletesEntry() throws {
        let container = try createTestContainer()
        let context = ModelContext(container)

        let entry = Entry(turkish: "To Delete", german: "Zu löschen")
        context.insert(entry)
        try context.save()

        context.delete(entry)
        try context.save()

        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)
        #expect(fetched.isEmpty)
    }

    @Test
    func updatesEntry() throws {
        let container = try createTestContainer()
        let context = ModelContext(container)

        let entry = Entry(turkish: "Original", german: "Original")
        context.insert(entry)
        try context.save()

        entry.turkish = "Updated"
        try context.save()

        let descriptor = FetchDescriptor<Entry>()
        let fetched = try context.fetch(descriptor)
        #expect(fetched[0].turkish == "Updated")
    }
}
