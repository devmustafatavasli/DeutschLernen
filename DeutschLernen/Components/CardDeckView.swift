import SwiftUI

enum DeckSwipeDirection {
    case up
    case left
    case right
}

struct CardDeckView<Item: Identifiable, CardContent: View>: View {
    let items: [Item]
    var maxVisible: Int = 3
    @ViewBuilder var cardContent: (Item) -> CardContent
    var interpretDrag: (CGSize) -> DeckSwipeDirection?
    var onSwipe: (Item, DeckSwipeDirection) -> Void
    var cardColor: (Item) -> CardColor = { _ in .red }

    @State private var dragTranslation: CGSize = .zero
    private let cardHeight: CGFloat = 220
    private let cardSpacing: CGFloat = 24

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(Array(items.prefix(maxVisible).enumerated()), id: \.element.id) { index, item in
                ZStack {
                    cardColor(item).background()
                        .cornerRadius(16)

                    cardContent(item)
                        .lineLimit(3)
                }
                .frame(height: cardHeight)
                .scaleEffect(1 - CGFloat(index) * 0.06, anchor: .top)
                .offset(y: CGFloat(index) * cardSpacing)
                .zIndex(Double(maxVisible - index))
                .gesture(index == 0 ? frontDragGesture(for: item) : nil)
                .offset(index == 0 ? dragTranslation : .zero)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func frontDragGesture(for item: Item) -> some Gesture {
        DragGesture()
            .onChanged { dragTranslation = $0.translation }
            .onEnded { value in
                if let direction = interpretDrag(value.translation) {
                    exit(item, direction)
                } else {
                    withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                        dragTranslation = .zero
                    }
                }
            }
    }

    private func exit(_ item: Item, _ direction: DeckSwipeDirection) {
        let target: CGSize = switch direction {
        case .up: CGSize(width: 0, height: -800)
        case .left: CGSize(width: -800, height: 0)
        case .right: CGSize(width: 800, height: 0)
        }
        withAnimation(.easeOut(duration: 0.4)) { dragTranslation = target }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            onSwipe(item, direction)
            dragTranslation = .zero
        }
    }
}
