import XCTest
import AoC2021

final class AoC2021Day5Tests: XCTestCase {
    let day = Day5()
    var inputFileName: String { "input\(Day5.self)"}

    let sampleInput = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day.part1(sampleInput), 5)
    }

    func testPart1() {
        XCTAssertEqual(day.part1(input), 6267)
    }

    func testPart2Sample() {
        XCTAssertEqual(day.part2(sampleInput), 12)
    }

    func testDay1Part2() {
        XCTAssertEqual(day.part2(input), 20196)
    }
}
