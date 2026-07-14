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

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Hakkında") {
                    LabeledContent("Sürüm", value: appVersion)
                    Text("DeutschLernen, Türkçe'den Almanca'ya günlük ifadeleri yakalayıp tekrar etmek için kişisel bir uygulama.")
                }
                Section {
                    Link("Kısayollar Uygulamasını Aç", destination: URL(string: "shortcuts://")!)
                }
            }
            .navigationTitle("Ayarlar")
        }
    }

    private var appVersion: String {
        let short = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
        return "\(short) (\(build))"
    }
}

#Preview {
    RootView()
        .modelContainer(for: Entry.self, inMemory: true)
}
