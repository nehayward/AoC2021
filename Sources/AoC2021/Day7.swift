import Foundation
import AppKit

/// 🦀
final public class Day7: Day {
    public init() {}
    
    public func part1(_ input: String) -> Int {
        let crabPositions: [Int] = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").compactMap(Int.init)
        let myDict = crabPositions.reduce(into: [Int: Int]()) {
            $0[$1, default: 0] += 1
        }

        let key = myDict.sorted { value1, value2 in
            value1.value > value2.value
        }

        print(key[0])
        var pointToAlign = key[0].key

        var minFuel = Int.max
        for key in myDict.keys {
            var totalFuel = 0
            for position in crabPositions {
                totalFuel += abs(position - key)
            }
            minFuel = min(minFuel, totalFuel)
        }

        print(minFuel)
        return 0
    }

    public func part2(_ input: String) -> Int {
        let crabPositions: [Int] = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").compactMap(Int.init)
        let sorted = crabPositions.sorted(by: <)
        print(sorted.first, sorted.last)

//        let key = myDict.sorted { value1, value2 in
//            value1.value > value2.value
//        }
//
//        print(key[0])
//        var pointToAlign = key[0].key

        var minFuel = Int.max
//        let key = 5

        for key in sorted.first!...sorted.last! {
            var totalFuel = 0
            for position in crabPositions {
                let starting = min(key, position)
                let ending = max(key, position)

                for (i, _) in (starting...ending).enumerated() {
                    totalFuel += i
                }
//                print(totalFuel)
            }
            minFuel = min(minFuel, totalFuel)
        }

        print(minFuel)
        return minFuel
    }
}
