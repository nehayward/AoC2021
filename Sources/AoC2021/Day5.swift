import Foundation
import AppKit

public class Day5 {
    public init() { }

    public func part1(_ input: String) -> Int {
        var hitMap: [Point: Int] = [:]

        let lines = input.components(separatedBy: .newlines).compactMap(Line.init)
        lines.forEach { line in
            print(line.hasLine)
            print(line.allPoints)
            line.allPoints.forEach { point in
                hitMap[point, default: 0] += 1
            }
        }

        var numberOfLineOverlap = 0
        for point in hitMap {
            if point.value >= 2 {
                print("Found, \(point.key)")
                numberOfLineOverlap += 1
            }
        }
        return numberOfLineOverlap
    }

    public func part2(_ input: String) -> Int {
        var hitMap: [Point: Int] = [:]

        let lines = input.components(separatedBy: .newlines).compactMap(Line.init)
        lines.forEach { line in

            line.allPoints.forEach { point in
                hitMap[point, default: 0] += 1
            }

            line.allDiagonalPoints.forEach { point in
                hitMap[point, default: 0] += 1
            }
        }

        var numberOfLineOverlap = 0
        for point in hitMap {
            if point.value >= 2 {
//                print("Found, \(point.key)")
                numberOfLineOverlap += 1
            }
        }
        return numberOfLineOverlap
    }

    func angle(between starting: Point, ending: Point) -> CGFloat {
        let center = Point(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(Double(center.y), Double(center.x))
        let degrees = radians * 180 / .pi
        return degrees > 0 ? degrees : degrees + degrees
    }
}

extension Day5 {
    struct Line {
        let startPoint: Point
        let endPoint: Point
        // For now, only consider horizontal and vertical lines: lines where either x1 = x2 or y1 = y2.
        var hasLine: Bool {
            startPoint.x == endPoint.x || startPoint.y == endPoint.y
        }

        var is45: Bool {
            let dx = startPoint.x - endPoint.x
            let dy = startPoint.y - endPoint.y

            if abs(dx) == abs(dy) {
                print(45)
                print(self)
                return true
            }
            return false
        }

        var allPoints: [Point] {
            if startPoint.x == endPoint.x {
                let begin = Int(min(startPoint.y, endPoint.y))
                let end = Int(max(startPoint.y, endPoint.y))
                var points: [Point] = []

                for i in (begin...end) {
                    let point = Point(x: Int(startPoint.x), y: i)
                    points.append(point)
                }
                return points
            }

            if startPoint.y == endPoint.y {
                let begin = Int(min(startPoint.x, endPoint.x))
                let end = Int(max(startPoint.x, endPoint.x))
                var points: [Point] = []

                for i in (begin...end) {
                    let point = Point(x: i, y: Int(startPoint.y))
                    points.append(point)
                }
                return points
            }

            return []
        }

        var allDiagonalPoints: [Point] {
            if !is45 { return [] }

            if startPoint.x < endPoint.x {
                var points: [Point] = []
                var multiplier = 1

                if startPoint.y > endPoint.y {
                    multiplier = -1
                }

                for (index, element) in (startPoint.x...endPoint.x).enumerated() {
                    let point = Point(x: element, y: startPoint.y + (index * multiplier))
                    points.append(point)
                }
                return points
            }

            if startPoint.x > endPoint.x {
                var points: [Point] = []
                var multiplier = 1

                if endPoint.y > startPoint.y {
                    multiplier = -1
                }

                for (index, element) in (endPoint.x...startPoint.x).enumerated() {
                    let point = Point(x: element, y: endPoint.y + (index * multiplier))
                    points.append(point)
                }
                return points
            }

          
            return []
        }

        init?(rawString: String) {
            if rawString.isEmpty { return nil }
            let points = rawString.components(separatedBy: "->")
            let start = points[0].components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespaces)}
            let end = points[1].components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespaces)}
            self.startPoint = Point(x: Int(start[0])!, y: Int(start[1])!)
            self.endPoint = Point(x: Int(end[0])!, y: Int(end[1])!)
        }
    }

    struct Point: Hashable {
        let x: Int
        let y: Int
    }


}


extension Day5.Point {
    func angle(ending: Self) -> CGFloat {
        let center = Self(x: ending.x - self.x, y: ending.y - self.y)
        let radians = atan2(Double(center.y), Double(center.x))
        let degrees = radians * 180 / .pi
        return degrees > 0 ? degrees : degrees + degrees
    }
}
