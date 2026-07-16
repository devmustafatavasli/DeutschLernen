import SwiftUI

enum CardColor: Hashable, CaseIterable {
    case red
    case green
    case blue
    case yellow
    case purple

    func background() -> Color {
        switch self {
        case .red:    return Color(red: 0.99, green: 0.87, blue: 0.87)
        case .green:  return Color(red: 0.87, green: 0.99, blue: 0.87)
        case .blue:   return Color(red: 0.87, green: 0.93, blue: 0.99)
        case .yellow: return Color(red: 0.99, green: 0.97, blue: 0.87)
        case .purple: return Color(red: 0.95, green: 0.87, blue: 0.99)
        }
    }

    static func forIndex(_ index: Int) -> CardColor {
        // Sabit renk paletini döngüsel olarak ata; giriş sayısı herhangi bir miktar olabilir.
        Self.allCases[index % Self.allCases.count]
    }
}
