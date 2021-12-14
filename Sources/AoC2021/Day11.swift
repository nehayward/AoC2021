import Foundation
import AppKit

final public class Day11: Day {
    typealias Flashes = Int
    public init() {}

    public func part1(_ input: String) -> Int {
        let grid = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { string -> [Int] in
            let row = string.map(String.init).compactMap(Int.init)
            return row
        }

        var totalFlashes = 0
        var currentGrid = grid
        for i in 0..<100 {
            print("----------- Step \(i) -----------")
            let results = flash(currentGrid)
            totalFlashes += results.0
            currentGrid = results.1
        }

        print(totalFlashes)
        return totalFlashes
    }

    public func part2(_ input: String) -> Int {
        let grid = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { string -> [Int] in
            let row = string.map(String.init).compactMap(Int.init)
            return row
        }

        let allFlashes = Array(repeating: Array(repeating: 0, count: 10), count: 10)

        var totalFlashes = 0
        var currentGrid = grid
        var steps = 0
        while currentGrid != allFlashes {
            print("----------- Step \(steps) -----------")
            let results = flash(currentGrid)
            totalFlashes += results.0
            currentGrid = results.1
            steps += 1
        }
        print(steps)
        return steps
    }

    private func flash(_ grid: [[Int]]) -> (Flashes, [[Int]]) {
        var grid = grid

        for col in grid.enumerated() {
            for row in col.element.enumerated() {
                grid[col.offset][row.offset] += 1
            }
        }

        // Process Flashes
        var hasFlashed: [Point: Bool] = [:]

        while true {
            for col in grid.enumerated() {
                for row in col.element.enumerated() {
                    let point = Point(x: row.offset, y: col.offset)
                    if grid[col.offset][row.offset] > 9 {
                        grid[point.y][point.x] = 0

                        // Flash Nearby
                        if !hasFlashed[point, default: false] {
                            hasFlashed[point] = true
                            grid = process(point: point, grid: grid, hasFlashed)
                        }
                    }
                }
            }

            var flag = false
            grid.forEach { row in
                row.forEach { number in
                    if number >= 10 {
                        flag = true
                    }
                }
            }

            if !flag {
                break
            }
        }
        hasFlashed.keys.forEach { point in
            grid[point.y][point.x] = 0
        }
        printGrid(grid)

        return (hasFlashed.count, grid)
    }

    private func process(point: Point, grid: [[Int]], _ hasFlashed: [Point: Bool]) -> [[Int]] {
        var grid = grid
        // Check North
        if point.y - 1 >= 0 {
//            print("North: \(grid[point.y - 1][point.x])")

            let northPoint = Point(x: point.x, y: point.y - 1)
            if !hasFlashed[northPoint, default: false] {
                grid[point.y - 1][point.x] += 1
            }
        }

        // Check South
        if point.y + 1 < grid.count {
//            print("South: \(grid[point.y + 1][point.x])")

            let southPoint = Point(x: point.x, y: point.y + 1)
            if !hasFlashed[southPoint, default: false] {
                grid[southPoint.y][southPoint.x] += 1
            }
        }

        // Check East
        if point.x + 1 < grid[0].count {
//            print("East: \(grid[point.y][point.x + 1])")

            let eastPoint = Point(x: point.x + 1, y: point.y)
            if !hasFlashed[eastPoint, default: false] {
                grid[eastPoint.y][eastPoint.x] += 1
            }
        }

        // Check West
        if point.x - 1 >= 0 {
//            print("West: \(grid[point.y][point.x - 1])")

            let westPoint = Point(x: point.x - 1, y: point.y)
            if !hasFlashed[westPoint, default: false] {
                grid[westPoint.y][westPoint.x] += 1
            }
        }

        // North East
        if point.y - 1 >= 0 && point.x + 1 < grid[0].count {
//            print("NorthEast: \(grid[point.y - 1][point.x + 1])")

            let northEast = Point(x: point.x + 1, y: point.y - 1)
            if !hasFlashed[northEast, default: false] {
                grid[northEast.y][northEast.x] += 1
            }
        }

        // North West
        if point.y - 1 >= 0 && point.x - 1 >= 0 {
//            print("NorthWest: \(grid[point.y - 1][point.x - 1])")
            let northWest = Point(x: point.x - 1, y: point.y - 1)
            if !hasFlashed[northWest, default: false] {
                grid[northWest.y][northWest.x] += 1
            }
        }

        // South East
        if point.y + 1 < grid.count && point.x + 1 < grid[0].count  {
//            print("SouthEast: \(grid[point.y + 1][point.x + 1])")

            let southEast = Point(x: point.x + 1, y: point.y + 1)
            if !hasFlashed[southEast, default: false] {
                grid[southEast.y][southEast.x] += 1
            }
        }

        // South West
        if point.y + 1 < grid.count && point.x - 1 >= 0  {
//            print("SouthWest: \(grid[point.y + 1][point.x - 1])")
            let southWest = Point(x: point.x - 1, y: point.y + 1)
            if !hasFlashed[southWest, default: false] {
                grid[southWest.y][southWest.x] += 1
            }
        }

        return grid
    }

    private func printGrid(_ grid: [[Int]]) {
        for col in grid {
            for row in col {
                print(row, terminator: "")
            }
            print("")
        }
        print("")
    }
}

extension Day11 {
    struct Point: Hashable {
        let x: Int
        let y: Int
    }
}
