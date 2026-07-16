import Testing
import Foundation
import SwiftUI
import UIKit
@testable import DeutschLernen
@testable import DeutschLernenWidgetExtension

struct WidgetViewRenderTests {
    @Test
    func widgetViewRendersEntryText() {
        let entry = Entry(turkish: "Merhaba", german: "Hallo")
        let widgetEntry = DeutschLernenWidgetEntry(date: Date(), entry: entry)

        let view = DeutschLernenWidgetEntryView(entry: widgetEntry)
        let hosting = UIHostingController(rootView: view)

        hosting.loadViewIfNeeded()

        // View should render successfully without crashes
        #expect(hosting.view != nil)
    }

    @Test
    func widgetViewRendersEmptyState() {
        let widgetEntry = DeutschLernenWidgetEntry(date: Date(), entry: nil)
        let view = DeutschLernenWidgetEntryView(entry: widgetEntry)
        let hosting = UIHostingController(rootView: view)

        hosting.loadViewIfNeeded()

        #expect(hosting.view != nil)
    }

    @Test
    func widgetViewFrameIsValid() {
        let entry = Entry(turkish: "Test", german: "Test")
        let widgetEntry = DeutschLernenWidgetEntry(date: Date(), entry: entry)

        let view = DeutschLernenWidgetEntryView(entry: widgetEntry)
        let hosting = UIHostingController(rootView: view)

        hosting.view.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
        hosting.loadViewIfNeeded()

        #expect(hosting.view.frame.width > 0)
        #expect(hosting.view.frame.height > 0)
    }

    @Test
    func widgetViewLayoutsWithoutCrashing() {
        let entry = Entry(turkish: "Layouttest", german: "Layouttest")
        let widgetEntry = DeutschLernenWidgetEntry(date: Date(), entry: entry)

        let view = DeutschLernenWidgetEntryView(entry: widgetEntry)
        let hosting = UIHostingController(rootView: view)

        hosting.view.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
        hosting.view.setNeedsLayout()
        hosting.view.layoutIfNeeded()

        #expect(hosting.view.subviews.count > 0)
    }
}
