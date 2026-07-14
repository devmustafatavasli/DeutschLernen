import SwiftUI
import SwiftData

struct RootView: View {
    var body: some View {
        TabView {
            EntriesView()
                .tabItem {
                    Label("Kayıtlar", systemImage: "list.bullet.rectangle")
                }

            TestView()
                .tabItem {
                    Label("Test", systemImage: "rectangle.stack")
                }

            SettingsView()
                .tabItem {
                    Label("Ayarlar", systemImage: "gear")
                }
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: Entry.self, inMemory: true)
}
