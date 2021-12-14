import Foundation
import AppKit

/// Lantern Fish 🐟
public class Day6 {
    private static let numberOfDays = 80

    public init() { }

    public func part1(_ input: String) -> Int {
        var lanternFishs = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").compactMap(Int.init).map(LanternFish.init)
        print(lanternFishs)

        for _ in 0..<80 {
            var newFishToAppend: [LanternFish] = []
            for (index, _) in lanternFishs.enumerated() {
                var lanternFish = lanternFishs[index]
                if lanternFish.timer == 0 {
                    lanternFish.reset()
                    lanternFishs[index] = lanternFish
                    newFishToAppend.append(LanternFish())
                } else {
                    lanternFish.timer -= 1
                    lanternFishs[index] = lanternFish
                }
            }

            lanternFishs.append(contentsOf: newFishToAppend)
            newFishToAppend.removeAll()
        }
        
        return lanternFishs.count
    }

    public func part2(_ input: String) -> Int {
        var lanternFishs = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").compactMap(Int.init).map(LanternFish.init)
        print(lanternFishs)

        var pods: [Pod] = []

        for _ in 0..<256 {
            var numberToAppend = 0
            for (i, _) in pods.enumerated() {
                if pods[i].daysRemaining == 0 {
                    pods[i].reset()
                    numberToAppend += pods[i].totalNumber
                } else {
                    pods[i].daysRemaining -= 1
                }
            }
            for (index, _) in lanternFishs.enumerated() {
                if lanternFishs[index].timer == 0 {
                    lanternFishs[index].reset()
                    numberToAppend += 1
                } else {
                    lanternFishs[index].timer -= 1
                }
            }
            pods.append(Pod(totalNumber: numberToAppend))
        }

        let total = lanternFishs.count + pods.reduce(0, { partialResult, pod in
            partialResult + pod.totalNumber
        })
        print(total)

        return total
    }
}



extension Day6 {
    struct LanternFish: CustomStringConvertible {
        var timer: Int

        init(spawnTimer: Int = 8) {
            self.timer = spawnTimer
        }

        mutating func reset() {
            timer = 6
        }

        var description: String {
            "\(timer)"
        }
    }

    struct Pod {
        var daysRemaining: Int
        let totalNumber: Int

        init(totalNumber: Int, daysRemaining: Int = 8) {
            self.totalNumber = totalNumber
            self.daysRemaining = daysRemaining
        }

        mutating func reset() {
            daysRemaining = 6
        }
    }
}
