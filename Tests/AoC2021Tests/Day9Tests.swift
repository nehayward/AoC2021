import XCTest
import AoC2021

final class Day9Tests: XCTestCase {
    let day = Day9()
    var inputName: String {"\(Self.self)"}
    var inputFileName: String { "input\(inputName.dropLast(5))"}

    let sampleInput = """
2199943210
3987894921
9856789892
8767896789
9899965678
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day.part1(sampleInput), 15)
    }

    func testPart1() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part1(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 494)
    }

    func testPart2Sample() {
        XCTAssertEqual(day.part2(sampleInput), 1134)
    }

    func testDay1Part2() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 1048128)
    }
}
