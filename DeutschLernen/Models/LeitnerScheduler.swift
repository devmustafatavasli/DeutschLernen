import Foundation
import SwiftData

extension Entry {
    func recordGrade(correct: Bool) {
        if correct {
            box = min(box + 1, 5)
            correctCount += 1
        } else {
            box = 1
            wrongCount += 1
        }
        lastReviewedAt = Date()
    }
}

enum LeitnerScheduler {
    // Ağırlıklı rastgele seçim: kutu numarası düşük olan kart daha sık gelsin.
    static func weightedNextEntry(excluding current: Entry?, from pool: [Entry]) -> Entry? {
        let candidates = pool.count > 1 ? pool.filter { $0.persistentModelID != current?.persistentModelID } : pool
        guard !candidates.isEmpty else { return nil }

        let maxBox = candidates.map(\.box).max() ?? 5
        let weights = candidates.map { Double(maxBox + 1 - $0.box) }
        let total = weights.reduce(0, +)

        var r = Double.random(in: 0..<total)
        for (entry, weight) in zip(candidates, weights) {
            if r < weight { return entry }
            r -= weight
        }
        return candidates.last
    }
}
