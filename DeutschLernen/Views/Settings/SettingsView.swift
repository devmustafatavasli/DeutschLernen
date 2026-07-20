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
                                .foregroundStyle(AppColor.textTertiary)
                        }
                        .foregroundStyle(AppColor.textPrimary)
                    }
                }

                Section {
                    Link("Kısayollar Uygulamasını Aç", destination: URL(string: "shortcuts://")!)
                        .foregroundStyle(AppColor.primary)
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
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    Text("Action Button Kurulumu")
                        .font(AppTypography.title2)
                        .foregroundStyle(AppColor.textPrimary)

                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        HStack(alignment: .top, spacing: AppSpacing.md) {
                            Text("1")
                                .font(AppTypography.captionEmphasis)
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(AppColor.primary))

                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text("Kısayollar Uygulamasını Aç")
                                    .font(AppTypography.bodyEmphasis)
                                    .foregroundStyle(AppColor.textPrimary)
                                Text("Telefonunuzda Kısayollar uygulamasını açın.")
                                    .font(AppTypography.caption)
                                    .foregroundStyle(AppColor.textSecondary)
                            }
                        }

                        HStack(alignment: .top, spacing: AppSpacing.md) {
                            Text("2")
                                .font(AppTypography.captionEmphasis)
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(AppColor.primary))

                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text("Yeni Kısayol Oluştur")
                                    .font(AppTypography.bodyEmphasis)
                                    .foregroundStyle(AppColor.textPrimary)
                                Text("'+' tuşuna basarak yeni bir kısayol başlatın.")
                                    .font(AppTypography.caption)
                                    .foregroundStyle(AppColor.textSecondary)
                            }
                        }

                        HStack(alignment: .top, spacing: AppSpacing.md) {
                            Text("3")
                                .font(AppTypography.captionEmphasis)
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(AppColor.primary))

                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text("Aksiyonları Ekle")
                                    .font(AppTypography.bodyEmphasis)
                                    .foregroundStyle(AppColor.textPrimary)
                                Text("Aşağıdaki sırayla aksiyonları ekleyin:")
                                    .font(AppTypography.caption)
                                    .foregroundStyle(AppColor.textSecondary)

                                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                    Text("a) Dictate Text (Türkçe konuş)")
                                    Text("b) Translate (Turkish → German)")
                                    Text("c) Open DeutschLernen (Add Entry)")
                                }
                                .font(AppTypography.caption)
                                .foregroundStyle(AppColor.textSecondary)
                                .padding(.top, AppSpacing.md)
                            }
                        }

                        HStack(alignment: .top, spacing: AppSpacing.md) {
                            Text("4")
                                .font(AppTypography.captionEmphasis)
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Circle().fill(AppColor.primary))

                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text("Action Button'a Ata")
                                    .font(AppTypography.bodyEmphasis)
                                    .foregroundStyle(AppColor.textPrimary)
                                Text("Ayarlar → Action Button'a gidin ve bu kısayolu seçin.")
                                    .font(AppTypography.caption)
                                    .foregroundStyle(AppColor.textSecondary)
                            }
                        }
                    }
                    .padding(.top, AppSpacing.md)

                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Ayrıntılı Adımlar")
                            .font(AppTypography.bodyEmphasis)
                            .foregroundStyle(AppColor.textPrimary)

                        Text("Kısayol akışı:")
                            .font(AppTypography.captionEmphasis)
                            .foregroundStyle(AppColor.textPrimary)

                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("1. 'Dictate Text' aksiyonunu ekleyin")
                            Text("2. 'Translate' aksiyonunu ekleyin:")
                            Text("   - From: Turkish")
                            Text("   - To: German")
                            Text("   - Text: Dictate Text sonucu")
                            Text("3. DeutschLernen uygulamasında 'Add Entry' Intent'i çalıştırın:")
                            Text("   - Turkish: Dictate Text sonucu")
                            Text("   - German: Translate sonucu")
                        }
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColor.textSecondary)
                        .lineLimit(nil)
                    }

                    Spacer()

                    Button(action: { dismiss() }) {
                        Text("Anladım")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(AppColor.primary)
                }
                .padding(AppSpacing.lg)
            }
            .navigationTitle("Action Button")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
