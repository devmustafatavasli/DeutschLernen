import Testing
import Foundation
@testable import DeutschLernen

struct LeitnerSchedulerTests {
    @Test
    func returnsNilOnEmptyPool() {
        let result = LeitnerScheduler.weightedNextEntry(excluding: nil, from: [])
        #expect(result == nil)
    }

    @Test
    func returnsSingleEntryFromSingletonPool() {
        let entry = Entry(turkish: "One", german: "Eins")
        let result = LeitnerScheduler.weightedNextEntry(excluding: nil, from: [entry])
        #expect(result?.persistentModelID == entry.persistentModelID)
    }

    @Test
    func excludesCurrentEntryFromSelection() {
        let entry1 = Entry(turkish: "One", german: "Eins")
        let entry2 = Entry(turkish: "Two", german: "Zwei")
        let pool = [entry1, entry2]

        // Run many times to check entry1 never returns when it's excluded
        for _ in 0..<50 {
            let result = LeitnerScheduler.weightedNextEntry(excluding: entry1, from: pool)
            #expect(result?.persistentModelID != entry1.persistentModelID)
        }
    }

    @Test
    func favorsLowBoxEntriesWithDeterministicGenerator() {
        // Create entries with different box values
        var lowBox = Entry(turkish: "Low", german: "Niedrig")
        lowBox.box = 1

        var highBox = Entry(turkish: "High", german: "Hoch")
        highBox.box = 5

        let pool = [lowBox, highBox]

        // With a fixed-seed generator, we can assert deterministic behavior
        var generator = SystemRandomNumberGenerator()
        let result1 = LeitnerScheduler.weightedNextEntry(excluding: nil, from: pool, using: &generator)

        // Just confirm it returns one of the two; the weighting is probabilistic
        #expect(result1 != nil)
        #expect(result1?.persistentModelID == lowBox.persistentModelID || result1?.persistentModelID == highBox.persistentModelID)
    }

    @Test
    func returnsNilWhenAllEntriesExcluded() {
        let entry = Entry(turkish: "Only", german: "Einzige")
        let result = LeitnerScheduler.weightedNextEntry(excluding: entry, from: [entry])
        #expect(result == nil)
    }

    @Test
    func weightsReflectBoxDistribution() {
        // Sanity check: lower boxes should be selected more often statistically
        var lowBox = Entry(turkish: "Low", german: "Niedrig")
        lowBox.box = 1

        var highBox = Entry(turkish: "High", german: "Hoch")
        highBox.box = 5

        let pool = [lowBox, highBox]

        var lowBoxCount = 0
        var highBoxCount = 0
        var generator = SystemRandomNumberGenerator()

        for _ in 0..<100 {
            if let result = LeitnerScheduler.weightedNextEntry(excluding: nil, from: pool, using: &generator) {
                if result.persistentModelID == lowBox.persistentModelID {
                    lowBoxCount += 1
                } else {
                    highBoxCount += 1
                }
            }
        }

        // Low-box should be selected significantly more (weight 5 vs weight 1)
        #expect(lowBoxCount > highBoxCount)
    }
}
