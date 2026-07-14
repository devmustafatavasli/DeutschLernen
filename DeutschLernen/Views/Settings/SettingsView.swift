import SwiftUI

struct SettingsView: View {
    @State private var showShortcutSetup = false

    var body: some View {
        NavigationStack {
            List {
                Section("Uygulama") {
                    LabeledContent("Sürüm", value: appVersion)
                }

                Section("Action Button Kurulumu") {
                    Button(action: { showShortcutSetup = true }) {
                        HStack {
                            Label("Action Button'ı Konfigüre Et", systemImage: "cube.transparent")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .foregroundStyle(.primary)
                    }
                }

                Section {
                    Link("Kısayollar Uygulamasını Aç", destination: URL(string: "shortcuts://")!)
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Ayarlar")
            .sheet(isPresented: $showShortcutSetup) {
                ActionButtonSetupView()
            }
        }
    }

    private var appVersion: String {
        let short = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(short) (\(build))"
    }
}

struct ActionButtonSetupView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Action Button Kurulumu")
                        .font(.title2.weight(.semibold))

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top, spacing: 12) {
                            Text("1")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(Color.blue))

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Kısayollar Uygulamasını Aç")
                                    .font(.headline)
                                Text("Telefonunuzda Kısayollar uygulamasını açın.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        HStack(alignment: .top, spacing: 12) {
                            Text("2")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(Color.blue))

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Yeni Kısayol Oluştur")
                                    .font(.headline)
                                Text("'+' tuşuna basarak yeni bir kısayol başlatın.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        HStack(alignment: .top, spacing: 12) {
                            Text("3")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(Color.blue))

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Aksiyonları Ekle")
                                    .font(.headline)
                                Text("Aşağıdaki sırayla aksiyonları ekleyin:")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("a) Dictate Text (Türkçe konuş)")
                                    Text("b) Translate (Turkish → German)")
                                    Text("c) Open DeutschLernen (Add Entry)")
                                }
                                .font(.caption)
                                .padding(.top, 8)
                            }
                        }

                        HStack(alignment: .top, spacing: 12) {
                            Text("4")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(Color.blue))

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Action Button'a Ata")
                                    .font(.headline)
                                Text("Ayarlar → Action Button'a gidin ve bu kısayolu seçin.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(.top, 12)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ayrıntılı Adımlar")
                            .font(.headline)

                        Text("Kısayol akışı:")
                            .font(.caption.weight(.semibold))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. 'Dictate Text' aksiyonunu ekleyin")
                            Text("2. 'Translate' aksiyonunu ekleyin:")
                            Text("   - From: Turkish")
                            Text("   - To: German")
                            Text("   - Text: Dictate Text sonucu")
                            Text("3. DeutschLernen uygulamasında 'Add Entry' Intent'i çalıştırın:")
                            Text("   - Turkish: Dictate Text sonucu")
                            Text("   - German: Translate sonucu")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(nil)
                    }

                    Spacer()

                    Button(action: { dismiss() }) {
                        Text("Anladım")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Action Button")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
