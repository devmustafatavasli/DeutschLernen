import SwiftUI
import SwiftData

@main
struct DeutschLernenApp: App {
    init() {
        // UI tests: use in-memory store for isolation, never affecting the real App Group store.
        if CommandLine.arguments.contains("-UITesting") {
            let schema = Schema([Entry.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            do {
                DataStore.container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create test ModelContainer: \(error)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(DataStore.container)
    }
}
