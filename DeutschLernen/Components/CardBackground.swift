import SwiftUI

struct CardBackground: ViewModifier {
    // Sürüme göre arka plan efektini uyarlıyoruz.
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular, in: .rect(cornerRadius: 24))
        } else {
            content
                .background(.regularMaterial, in: .rect(cornerRadius: 24))
        }
    }
}
