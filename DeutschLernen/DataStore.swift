import Foundation
import SwiftData

enum DataStore {
    // App Group ID tek bir yerde, paylaşımlı olarak tutuyoruz.
    static let appGroupID = "group.com.devmustafatavasli.DeutschLernen"
    static let container: ModelContainer = {
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
}
