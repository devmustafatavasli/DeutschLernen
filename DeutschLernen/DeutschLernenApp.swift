import SwiftUI
import SwiftData

@main
struct DeutschLernenApp: App {
    var sharedModelContainer: ModelContainer = {
        // Entry modelini belirtiyoruz. Başka modelimiz yok.
        let schema = Schema([
            Entry.self,
        ])
        // Depolama ve group belirtme
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.devmustafatavasli.DeutschLernen"))
        // error-handling
        do {
            // db bağlantısı burada kuruluyor.
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
