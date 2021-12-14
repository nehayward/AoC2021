import Foundation
import AppKit

/// 🗺 = Navigation
final public class Day10: Day {
    public init() {}

    public func part1(_ input: String) -> Int {
        let subSystems = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)

        // Discard Corrupted = Invalid Open Close
        let points = subSystems.map(findCorruptedSystem)

        return points.reduce(0, +)
    }

    public func part2(_ input: String) -> Int {
        let subSystems = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)

        // Discard Corrupted = Invalid Open Close
        let incompleteSystems = subSystems.filter { findCorruptedSystem($0) == 0 }
        let completionStrings = incompleteSystems.map(completeStack)

        completionStrings.forEach {
            let stack = $0.reduce("") { partialResult, nav in
                partialResult.appending(nav.rawValue)
            }
            print(stack)
        }

        let totalScores = completionStrings.map(counter).sorted(by: <)
        print(totalScores)
        return totalScores[(totalScores.count-1)/2]
    }

    private func findCorruptedSystem(_ subSystem: String) -> Int {
        var stack: [Navigation] = []

        for i in subSystem.enumerated() {
            switch Navigation(rawValue: String(i.element))! {
                case .openParen, .openBracket, .openCurly, .openAngle:
                    stack.append(Navigation(rawValue: String(i.element))!)
                default:
                    guard let pop = stack.last else { continue }
                    if pop.closed(navigation: Navigation(rawValue: String(i.element))!) {
                        stack.removeLast()
                    } else {
                        print("Expected \(pop.rawValue), but found \(String(i.element))")
                        return Navigation(rawValue: String(i.element))!.points
                    }
            }
        }
        return 0
    }

    private func completeStack(_ subSystem: String) -> [Navigation] {
        var stack: [Navigation] = []

        for i in subSystem.enumerated() {
            switch Navigation(rawValue: String(i.element))! {
                case .openParen, .openBracket, .openCurly, .openAngle:
                    stack.append(Navigation(rawValue: String(i.element))!)
                default:
                    guard let pop = stack.last else { continue }
                    if pop.closed(navigation: Navigation(rawValue: String(i.element))!) {
                        stack.removeLast()
                    }
            }
        }

        let inverse = stack.reversed().map(\.inverse)
        return inverse
    }

    private func counter(completionStack: [Navigation]) -> Int {
        var totalPoint = 0

        for completion in completionStack.enumerated() {
            totalPoint = totalPoint * 5
            switch completion.element {
                case .closedParen:
                    let point = 1
                    totalPoint += point
                case .closedBracket:
                    let point = 2
                    totalPoint += point
                case .closedCurly:
                    let point = 3
                    totalPoint += point
                case .closedAngle:
                    let point = 4
                    totalPoint += point
                default:
                    break
            }
        }
        return totalPoint
    }
}

extension Day10 {
    enum Navigation: String {
        case openParen = "("
        case closedParen = ")"

        case openBracket = "["
        case closedBracket = "]"

        case openCurly = "{"
        case closedCurly = "}"

        case openAngle = "<"
        case closedAngle = ">"

        var points: Int {
            switch self {
                case .closedParen:
                    return 3
                case .closedBracket:
                    return 57
                case .closedCurly:
                    return 1197
                case .closedAngle:
                    return 25137
                default:
                    return 0
            }
        }

        func closed(navigation: Navigation) -> Bool {
            switch navigation {
                case .closedParen:
                    return self == .openParen
                case .closedBracket:
                    return self == .openBracket
                case .closedCurly:
                    return self == .openCurly
                case .closedAngle:
                    return self == .openAngle
                default:
                    return false
            }
        }

        var inverse: Navigation {
            switch self {
                case .openParen:
                    return .closedParen
                case .openBracket:
                    return .closedBracket
                case .openCurly:
                    return .closedCurly
                case .openAngle:
                    return .closedAngle
                default:
                    fatalError()
            }
        }
    }
}
