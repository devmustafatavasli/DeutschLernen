import SwiftUI
import SwiftData

struct RootView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Kayıtlar", systemImage: "list.bullet.rectangle")
                }

            TestPlaceholderView()
                .tabItem {
                    Label("Test", systemImage: "rectangle.stack")
                }

            SettingsPlaceholderView()
                .tabItem {
                    Label("Ayarlar", systemImage: "gear")
                }
        }
    }
}

struct TestPlaceholderView: View {
    var body: some View {
        NavigationStack {
            Text("Test modası burada gelecek")
                .navigationTitle("Test")
        }
    }
}

struct SettingsPlaceholderView: View {
    var body: some View {
        NavigationStack {
            Text("Ayarlar burada gelecek")
                .navigationTitle("Ayarlar")
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: Entry.self, inMemory: true)
}
