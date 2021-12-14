import XCTest
import AoC2021

final class Day13Tests: XCTestCase {
    let day = Day13()
    var inputName: String {"\(Self.self)"}
    var inputFileName: String { "input\(inputName.dropLast(5))"}

    let sampleInput = """
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day.part1(sampleInput), 0)
    }

    func testPart1() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part1(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 0)
    }

    func testPart2Sample() {
        XCTAssertEqual(day.part2(sampleInput), 0)
    }

    func testDay1Part2() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 0)
    }
}
