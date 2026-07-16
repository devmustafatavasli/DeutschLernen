import Foundation
import SwiftData

enum DataStore {
    // App Group ID tek bir yerde, paylaşımlı olarak tutuyoruz.
    static let appGroupID = "group.com.devmustafatavasli.DeutschLernen"

    // Tests swap this; must be var, not let.
    static var container: ModelContainer = {
        let schema = Schema([Entry.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier(appGroupID))
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // Shared defaults for the widget and related features, testable.
    static var sharedDefaults: UserDefaults {
        UserDefaults(suiteName: appGroupID) ?? UserDefaults.standard
    }
}
