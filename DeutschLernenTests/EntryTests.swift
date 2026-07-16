import Testing
import Foundation
@testable import DeutschLernen

struct EntryTests {
    @Test
    func initializesWithDefaultValues() {
        let entry = Entry(turkish: "Merhaba", german: "Hallo")

        #expect(entry.turkish == "Merhaba")
        #expect(entry.german == "Hallo")
        #expect(entry.box == 1)
        #expect(entry.isFavorite == false)
        #expect(entry.correctCount == 0)
        #expect(entry.wrongCount == 0)
        #expect(entry.lastReviewedAt == nil)
    }

    @Test
    func recordGradeIncreasesBoxOnCorrect() {
        let entry = Entry(turkish: "Test", german: "Test")
        let beforeTime = Date()

        entry.recordGrade(correct: true)

        let afterTime = Date()
        #expect(entry.box == 2)
        #expect(entry.correctCount == 1)
        #expect(entry.wrongCount == 0)
        #expect(entry.lastReviewedAt ?? beforeTime >= beforeTime)
        #expect(entry.lastReviewedAt ?? afterTime <= afterTime)
    }

    @Test
    func recordGradeResetsBoxOnIncorrect() {
        var entry = Entry(turkish: "Test", german: "Test")
        entry.box = 4

        entry.recordGrade(correct: false)

        #expect(entry.box == 1)
        #expect(entry.correctCount == 0)
        #expect(entry.wrongCount == 1)
    }

    @Test
    func recordGradeCapBoxAt5() {
        let entry = Entry(turkish: "Test", german: "Test")

        for _ in 0..<10 {
            entry.recordGrade(correct: true)
        }

        #expect(entry.box == 5)
    }
}
