import Foundation
import AppKit


/// 🔥 Lava flow heatmap
final public class Day9: Day {
    public init() {}

    /// Risk Level is 1 Plus its Height, Sum of all low points
    public func part1(_ input: String) -> Int {
        let heightMap: [[String]] = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { line in
            let row = line.map(String.init)
            print(row.joined())
            return row
        }

        var lowestPoints: [Int] = []
        for (y, row) in heightMap.enumerated() {
            for (x, _) in row.enumerated() {
                guard let lowPoint = checkAdjacent(point: (x, y), on: heightMap) else { continue }
                lowestPoints.append(lowPoint)
            }
        }

        let riskLevel = lowestPoints.map { $0 + 1 }.reduce(0, +)
        return riskLevel
    }

    /// Basin
    public func part2(_ input: String) -> Int {
        let heightMap: [[String]] = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { line in
            let row = line.map(String.init)
            print(row.joined())
            return row
        }

        var lowestPointsLocation: [(Int, Int)] = []
        for (y, row) in heightMap.enumerated() {
            for (x, _) in row.enumerated() {
                guard let lowPoint = checkAdjacent(point: (x, y), on: heightMap) else { continue }
                lowestPointsLocation.append((x,y))
                print((x,y))
            }
        }

        var basinSizes = [Int]()
        for lowestPoint in lowestPointsLocation {
            basinSizes.append(basinSize(observedPoint: lowestPoint, on: heightMap))
        }


        let max3 = basinSizes.sorted(by: <).suffix(3)
        print(max3)

        return max3.reduce(1, *)
    }

    private func checkAdjacent(point: (x: Int, y: Int), on map: [[String]]) -> Int? {
        let startingValue = map[point.y][point.x]
        print(startingValue)
        print(point)

        // Check North
        if point.y - 1 >= 0 {
            print("North: \(map[point.y - 1][point.x])")
            let northValue = map[point.y - 1][point.x]

            if startingValue >= northValue {
                return nil
            }
        }

        // Check South
        if point.y + 1 < map.count {
            print("South: \(map[point.y + 1][point.x])")
            let southValue = map[point.y + 1][point.x]
            if startingValue >= southValue {
                return nil
            }
        }

        // Check East
        if point.x + 1 < map[0].count {
            print("East: \(map[point.y][point.x + 1])")
            let eastValue = map[point.y][point.x + 1]
            if startingValue >= eastValue {
                return nil
            }
        }

        // Check West
        if point.x - 1 >= 0 {
            print("West: \(map[point.y][point.x - 1])")
            let westValue = map[point.y][point.x - 1]
            if startingValue >= westValue {
                return nil
            }
        }

        return Int(startingValue)
    }

    private func basinSize(observedPoint: (x: Int, y: Int), on map: [[String]]) -> Int {
        let firstPoint = Point(x: observedPoint.x, y: observedPoint.y)
        var seen: Set<Point> = Set(arrayLiteral: firstPoint)
        var queue: [Point] = [firstPoint]
        var safeValues: [String] = [map[firstPoint.y][firstPoint.x]]

        while !queue.isEmpty {
            let point = queue.removeFirst()
            print(point)
            // Check North
            if point.y - 1 >= 0 {
                let northValue = map[point.y - 1][point.x]
                let northPoint = Point(x: point.x, y: point.y - 1)
                if northValue != "9" {
                    if !seen.contains(northPoint) {
                        queue.append(northPoint)
                        seen.insert(northPoint)
                        safeValues.append(northValue)
                    }
                }
            }

            // Check South
            if point.y + 1 < map.count {
                print("South: \(map[point.y + 1][point.x])")
                let southValue = map[point.y + 1][point.x]
                let southPoint = Point(x: point.x, y: point.y + 1)
                if southValue != "9" {
                    if !seen.contains(southPoint) {
                        queue.append(southPoint)
                        seen.insert(southPoint)
                        safeValues.append(southValue)
                    }
                }
            }

            // Check East
            if point.x + 1 < map[0].count {
                print("East: \(map[point.y][point.x + 1])")
                let eastValue = map[point.y][point.x + 1]
                let eastPoint = Point(x: point.x + 1, y: point.y)
                if eastValue != "9" {
                    if !seen.contains(eastPoint) {
                        queue.append(eastPoint)
                        seen.insert(eastPoint)
                        safeValues.append(eastValue)
                    }
                }
            }

            // Check West
            if point.x - 1 >= 0 {
                print("West: \(map[point.y][point.x - 1])")
                let westValue = map[point.y][point.x - 1]
                let westPoint = Point(x: point.x - 1, y: point.y)
                if westValue != "9" {
                    if !seen.contains(westPoint) {
                        queue.append(westPoint)
                        seen.insert(westPoint)
                        safeValues.append(westValue)
                    }
                }
            }
        }

        return safeValues.count
    }
}

extension Day9 {
    struct Point: Hashable {
        let x: Int
        let y: Int
    }
}
