import Foundation
import AppKit

final public class Day8: Day {
    public init() {}

    public func part1(_ input: String) -> Int {
        let entries = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { line -> Entry in
            let entry = line.split(separator: "|")
            return Entry(signalPattern: entry[0].trimmingCharacters(in: .whitespaces), fourDigitOutput: entry[1].trimmingCharacters(in: .whitespaces))
        }

        var totalDigitCount = 0
        for entry in entries {
            for digitOutput in entry.fourDigitOutput.components(separatedBy: " ") {
                if UniqueNumberSegment(rawValue: digitOutput.count) != nil {
                    totalDigitCount += 1
                }
            }
        }

        return totalDigitCount
    }

    public func part2(_ input: String) -> Int {
        let entries = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map { line -> Entry in
            let entry = line.split(separator: "|")
            return Entry(signalPattern: entry[0].trimmingCharacters(in: .whitespaces), fourDigitOutput: entry[1].trimmingCharacters(in: .whitespaces))
        }

//        for entry in entries {
//            let identified = decipher(signals: entry.signalPattern)
//        }


        var totalDigitCount = 0
        for entry in entries {
            var digit = ""
            let identified = decipher(signals: entry.signalPattern)
            for digitOutput in entry.fourDigitOutput.components(separatedBy: " ") {
                digit.append(identified[String(digitOutput.sorted())]!)
            }
            print(digit)
            totalDigitCount += Int(digit)!
        }

        return totalDigitCount
    }

    private func decipher(signals: String) -> [String: String] {
        var segments: [String: String] = [:]
        var identified: [Int: String] = [:]
        var unKnowns: [String] = []

        for signal in signals.components(separatedBy: " ") {
            switch UniqueNumberSegment(rawValue: signal.count) {
                case .one:
                    segments[String(signal.sorted())] = "1"
                    identified[1] = String(signal.sorted())
                case .four:
                    segments[String(signal.sorted())] = "4"
                    identified[4] = signal
                case .seven:
                    segments[String(signal.sorted())] = "7"
                    identified[7] = signal
                case .eight:
                    segments[String(signal.sorted())] = "8"
                    identified[8] = signal
                default:
                    unKnowns.append(signal)
                    break
            }
        }

        while identified.count != 10 {
            if unKnowns.count == 1 {
                identified[0] = unKnowns.first!
                segments[String(unKnowns.first!.sorted())] = "0"
                unKnowns.removeAll()
                continue
            }
            for signal in unKnowns {
                if signal.count == 6 {
                    // 0, 6 or 9
                    let six = Set(signal).subtracting(Set(identified[7]!))
                    if six.count == 4 {
                        print(signal)
                        identified[6] = signal
                        segments[String(signal.sorted())] = "6"
                        unKnowns.removeAll(where: { $0 == signal })
                        continue
                    }

                    guard let threeSignal = identified[3] else { continue }
                    let nine = Set(signal).subtracting(Set(threeSignal))
                    if nine.count == 1 {
                        print(signal)
                        identified[9] = signal
                        segments[String(signal.sorted())] = "9"
                        unKnowns.removeAll(where: { $0 == signal })
                        continue
                    }


                } else {
                    // 2, 3, 5
                    let three = Set(signal).subtracting(Set(identified[1]!))
                    if three.count == 3 {
                        print(signal)
                        identified[3] = signal
                        segments[String(signal.sorted())] = "3"

                        unKnowns.removeAll(where: { $0 == signal })
                        continue
                    }

                    let two = Set(signal).subtracting(Set(identified[4]!))
                    if two.count == 2 {
                        print(signal)
                        identified[5] = signal
                        segments[String(signal.sorted())] = "5"
                        unKnowns.removeAll(where: { $0 == signal })
                        continue
                    }

                    print(signal)
                    identified[2] = signal
                    segments[String(signal.sorted())] = "2"
                    unKnowns.removeAll(where: { $0 == signal })
                    continue
                }
            }
        }
        let sorted = identified.sorted(by: <)
        print(sorted)
        return segments
    }
}

extension Day8 {
    struct Entry {
        let signalPattern: String
        let fourDigitOutput: String
    }

    enum UniqueNumberSegment: Int {
        case one = 2
        case four = 4
        case seven = 3
        case eight = 7
    }

    enum Number: String {
        case zero = "abcdeg"
        case two = "acdfg"
        case three = "abcdf"
        case five = "bcdef"
        case six = "acdefg"
        case nine = "bcdefg"
    }
}
