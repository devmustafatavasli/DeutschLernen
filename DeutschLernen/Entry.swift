import Foundation
import SwiftData

// MARK: Entry Model
// Kullanıcıdan alınacak olan ses verisinin uygulamadaki modelini temsil eder.
@Model
final class Entry {
    var turkish: String
    var german: String
    var createdAt: Date = Date()
    // Leitner modelinde kullanmak için değer tutuyoruz.
    var box: Int8 = 1
    var isFavorite: Bool = false
    var lastReviewedAt: Date?
    // Test sürecindeki işlemler için değer tutuyoruz.
    var correctCount: Int = 0
    var wrongCount: Int = 0
    // TR-DE verisi hariç hepsinin oluşturulması aynı şekilde oluyor.
    init (turkish: String, german: String) {
        self.turkish = turkish
        self.german = german
    }
}
