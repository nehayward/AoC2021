import Foundation
import AppKit

final public class Day14: Day {
    public init() {}

    public func part1(_ input: String) -> Int {
        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        let polymerTemplate = lines[0]
        let pairInsertions = lines[2..<lines.count]

        print(polymerTemplate)
        print(pairInsertions)
        var template = [Character](polymerTemplate)
        var pairs = [String:String]()

        pairInsertions.forEach { line in
            let rule = line.components(separatedBy: "->")
            let pair = rule[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let insertions = rule[1].trimmingCharacters(in: .whitespacesAndNewlines)
            pairs[pair] = insertions
        }

        print("Template:\t\(polymerTemplate)")

        for i in 1...10 {
            template = processRules(template, pairs)
            print("After step \(i)")
            print(String(template))
        }

        print(template.count)
        var characterKeys: [Character: Int] =  [:]

        template.forEach { character in
            characterKeys[character, default: 0] += 1
        }

        let sortedValues = characterKeys.values.sorted(by: <)
        let leastCommon = sortedValues.first!
        let mostCommon = sortedValues.last!

        let answer = mostCommon - leastCommon

        return answer
    }

    public func part2(_ input: String) -> Int {
        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        let polymerTemplate = lines[0]
        let pairInsertions = lines[2..<lines.count]

        print(polymerTemplate)
        print(pairInsertions)
        var template = [Character](polymerTemplate)
        var pairs = [String:String]()

        pairInsertions.forEach { line in
            let rule = line.components(separatedBy: "->")
            let pair = rule[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let insertions = rule[1].trimmingCharacters(in: .whitespacesAndNewlines)
            pairs[pair] = insertions
        }

        print("Template:\t\(polymerTemplate)")

        for i in 1...40 {
            template = processRules(template, pairs)
            print("After step \(i)")
//            print(String(template))
        }

        print(template.count)
        var characterKeys: [Character: Int] =  [:]

        template.forEach { character in
            characterKeys[character, default: 0] += 1
        }

        let sortedValues = characterKeys.values.sorted(by: <)
        let leastCommon = sortedValues.first!
        let mostCommon = sortedValues.last!

        let answer = mostCommon - leastCommon

        return answer
    }

    private func processRules(_ template: [Character], _ pairs: [String: String]) -> [Character] {
        var polymer = [Character]()
        for sequence in template.enumerated() {
            if sequence.offset < template.count - 1 {
                let pair = template[sequence.offset...sequence.offset+1]
//                print(pair)

                guard let insertion = pairs[String(pair)] else { continue }
//                print(insertion)
                polymer.append(template[template.index(0, offsetBy: sequence.offset)])
                polymer.append(Character(insertion))
//                print(polymer)
            }
        }
        polymer.append(template[template.index(0, offsetBy: (template.count-1))])

        return polymer
    }
}
