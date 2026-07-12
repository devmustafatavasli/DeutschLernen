import SwiftData
import AppIntents

struct AddEntryIntent: AppIntent {
    // Shortcuts aksiyonunun görünen adını belirledik.
    static var title: LocalizedStringResource = "Add Entry"
    // Alınacak iki parametreyi belirttik.
    @Parameter(title: "Turkish")
    var turkish: String
    @Parameter(title: "German")
    var german: String
    
    func perform() async throws -> some IntentResult {
        // Paylaşımlı erişimi burada kullanabiliyoruz.
        let context = ModelContext(DataStore.container)
        // Shortcut tarafından gelen veriyi ekliyoruz.
        let entry = Entry(turkish: turkish, german: german)
        context.insert(entry)
        try context.save()
        return .result()
    }
}
