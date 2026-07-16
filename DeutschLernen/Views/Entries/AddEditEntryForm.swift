import SwiftUI
import SwiftData

enum EntryFormMode: Identifiable {
    case create
    case edit(Entry)

    var id: String {
        switch self {
        // Her modalda benzersiz bir id, sheet'in durumunu yeniden oluşturmasını sağlar (state yeniden kullanmaması için).
        case .create: "create"
        case .edit(let entry): "edit-\(entry.persistentModelID)"
        }
    }
}

struct AddEditEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let mode: EntryFormMode
    @State private var turkish: String
    @State private var german: String

    init(mode: EntryFormMode) {
        self.mode = mode
        switch mode {
        case .create:
            _turkish = State(initialValue: "")
            _german = State(initialValue: "")
        case .edit(let entry):
            _turkish = State(initialValue: entry.turkish)
            _german = State(initialValue: entry.german)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Türkçe", text: $turkish)
                TextField("Almanca", text: $german)
            }
            .navigationTitle(isEditing ? "Düzenle" : "Yeni Kayıt")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") { save() }
                        .disabled(turkish.trimmingCharacters(in: .whitespaces).isEmpty
                                  || german.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private var isEditing: Bool {
        if case .edit = mode { true } else { false }
    }

    private func save() {
        switch mode {
        case .create:
            modelContext.insert(Entry(turkish: turkish, german: german))
        case .edit(let entry):
            entry.turkish = turkish
            entry.german = german
        }
        try? modelContext.save()
        dismiss()
    }
}
