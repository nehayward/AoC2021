import XCTest
import AoC2021

final class AoC2021Day3Tests: XCTestCase {
    let day3 = Day3()
    var inputFileName: String { "input\(Day3.self)"}

    let sampleInput = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day3.part1(sampleInput), 198)
    }

    func testPart1() {
        print(String(describing: Day3.self))
        XCTAssertEqual(day3.part1(input), 2954600)
    }

    func testPart2Sample() {
        XCTAssertEqual(day3.part2(sampleInput), 230)
    }

    func testDay1Part2() {
        XCTAssertEqual(day3.part2(input), 1662846)
    }
}
