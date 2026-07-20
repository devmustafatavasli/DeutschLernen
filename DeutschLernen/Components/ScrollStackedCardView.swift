import SwiftUI

struct ScrollStackedCardView<Item: Identifiable, CardContent: View>: View {
    let items: [Item]
    @ViewBuilder var cardContent: (Item) -> CardContent
    var cardColor: (Int) -> Color = { _ in AppColor.cardLight1 }

    @State private var scrollPosition: CGFloat = 0
    private let cardHeight: CGFloat = 360
    private let cardSpacing: CGFloat = 16

    var body: some View {
        ScrollView {
            VStack(spacing: cardSpacing) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    ZStack {
                        cardColor(index)
                            .ignoresSafeArea()

                        cardContent(item)
                    }
                    .frame(height: cardHeight)
                    .cornerRadius(AppSpacing.cornerLarge)
                    .scrollTransition(.interactive, axis: .vertical) { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            .offset(y: phase.isIdentity ? 0 : 10)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.vertical, AppSpacing.lg)
    }
}
