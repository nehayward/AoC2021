import Foundation
import AppKit

final public class Day12: Day {
    public init() {}

    public func part1(_ input: String) -> Int {
        let lines = input.components(separatedBy: .newlines)
        var paths: [Cave: Set<Cave>] = [:]
        lines.forEach { line in
            let cave = line.split(separator: "-").map(String.init).map(Cave.init)
            paths[cave[0], default: Set<Cave>()].insert(cave[1])
            if cave[0].name != "start" {
                paths[cave[1], default: Set<Cave>()].insert(cave[0])
            }
        }

        let distinctPaths = findPath(paths: paths)

        return 0
    }

    public func part2(_ input: String) -> Int {
        return 0
    }

    private func findPath(paths: [Cave: Set<Cave>]) -> [String] {
        var current: Cave = Cave(name: "start")
        var hasVisited: [Cave: Bool] = [:]
        var visitedPath = "start"
        var p: [String] = []

        let ab = deep(current: current, paths: paths, hasVisited: hasVisited, visitedPath: "")
        print(ab)
//
//        while current != Cave(name: "end") {
//            let caves = paths[current]
//            let next = caves?.first(where: { cave in
//                !hasVisited[cave, default: false]
//            })
//
//            if next!.size == .small {
//                hasVisited[next!] = true
//            }
//
//            visitedPath += ",\(next!.name)"
//            current = next!
//        }

        return [visitedPath]
    }

    private func deep(current: Cave, paths: [Cave: Set<Cave>], hasVisited: [Cave: Bool], visitedPath: String) -> String? {
        var hasVisited: [Cave: Bool] = hasVisited
        var visitedPath = visitedPath

        let caves = paths[current]
        let next = caves?.first(where: { cave in
            !hasVisited[cave, default: false]
        })

        guard let next = next else {
            return nil
        }

        if next.size == .small {
            hasVisited[next] = true
        }

        visitedPath += ",\(next.name)"

        if next.name == "end" {
            return visitedPath
        }

        return deep(current: next, paths: paths, hasVisited: hasVisited, visitedPath: visitedPath)
    }
}

struct Cave: Hashable, CustomStringConvertible {
    var description: String { name }

    let name: String
    var size: Size {
        if name.lowercased() == name {
            return .small
        }
        return .large
    }

    enum Size {
        case small
        case large
    }
}
