import Foundation

public class Day2 {
    public init() {
        
    }

    public func part1(_ input: String) -> Int {
        var startingPosition: CGPoint = CGPoint(x: 0, y: 0)

        let instructions = input.split(whereSeparator: \.isNewline).map(String.init)
        let positions = instructions.map(Position.init)

        positions.forEach { position in
            switch position {
                case let .forward(unit):
                    startingPosition.x += Double(unit)
                case let .down(unit):
                    startingPosition.y += Double(unit)
                case let .up(unit):
                    startingPosition.y -= Double(unit)
            }
        }

        print(startingPosition)
        return Int(startingPosition.x * startingPosition.y)
    }

    public func part2(_ input: String) -> Int {
        var submarine: (Int, Int, Int) = (0, 0, 0)

        let instructions = input.split(whereSeparator: \.isNewline).map(String.init)
        let positions = instructions.map(Position.init)

        positions.forEach { position in
            switch position {
                case let .forward(unit):
                    submarine.0 += unit
                    submarine.1 += (submarine.2 * unit)
                case let .down(unit):
                    submarine.2 += unit
                case let .up(unit):
                    submarine.2 -= unit
            }
        }

        print(submarine)
        return Int(submarine.0 * submarine.1)
    }
}

extension Day2 {
    enum Position {
        /// increases horizontal by x units
        case forward(unit: Int)

        /// increases the depth by x units
        case down(unit: Int)

        /// decreases the depth by x units
        case up(unit: Int)

        init (_ rawValue: String) {
            let position = rawValue.split(whereSeparator: \.isWhitespace).map(String.init)
            let p = position[0]
            let units = Int(position[1])!

            switch p {
                case "forward":
                    self = .forward(unit: units)
                case "down":
                    self = .down(unit: units)
                case "up":
                    self = .up(unit: units)
                default:
                    fatalError("Failed to parse position: \(rawValue)")
            }
        }
    }
}

extension Day2 {

}
