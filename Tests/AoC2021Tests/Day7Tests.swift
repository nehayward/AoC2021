import XCTest
import AoC2021

final class Day7Tests: XCTestCase {
    let day = Day7()
    var inputName: String {"\(Self.self)"}
    var inputFileName: String { "input\(inputName.dropLast(5))"}

    let sampleInput = """
16,1,2,0,4,2,7,1,2,14
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
        XCTAssertEqual(day.part1(input), 0)
    }

    func testPart2Sample() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(sampleInput)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 0)
    }

    func testDay1Part2() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 0)
    }
}
