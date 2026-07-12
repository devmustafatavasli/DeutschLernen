import SwiftUI
import SwiftData

@main
struct DeutschLernenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(DataStore.container)
    }
}
