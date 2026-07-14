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

    @State private var dragTranslation: CGSize = .zero
    @State private var isExiting = false

    var body: some View {
        ZStack {
            ForEach(Array(items.prefix(maxVisible).enumerated().reversed()), id: \.element.id) { index, item in
                cardContent(item)
                    .scaleEffect(1 - CGFloat(index) * 0.05)
                    .offset(y: CGFloat(index) * 10)
                    .opacity(index == 0 ? 1 : 0.85)
                    .offset(index == 0 ? dragTranslation : .zero)
                    .rotationEffect(index == 0 ? .degrees(Double(dragTranslation.width / 20)) : .zero)
                    .zIndex(Double(maxVisible - index))
                    .gesture(index == 0 ? frontDragGesture(for: item) : nil)
            }
        }
    }

    private func frontDragGesture(for item: Item) -> some Gesture {
        DragGesture()
            .onChanged { dragTranslation = $0.translation }
            .onEnded { value in
                if let direction = interpretDrag(value.translation) {
                    exit(item, direction)
                } else {
                    withAnimation(.spring) { dragTranslation = .zero }
                }
            }
    }

    private func exit(_ item: Item, _ direction: DeckSwipeDirection) {
        let target: CGSize = switch direction {
        case .up: CGSize(width: 0, height: -600)
        case .left: CGSize(width: -600, height: 0)
        case .right: CGSize(width: 600, height: 0)
        }
        withAnimation(.easeOut(duration: 0.25)) { dragTranslation = target }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            onSwipe(item, direction)
            dragTranslation = .zero
        }
    }
}
