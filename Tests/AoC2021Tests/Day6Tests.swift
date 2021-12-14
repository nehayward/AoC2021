import XCTest
import AoC2021

final class AoC2021Day6Tests: XCTestCase {
    let day = Day6()
    var inputFileName: String { "input\(Day6.self)"}

    let sampleInput = """
3,4,3,1,2
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day.part1(sampleInput), 5934)
    }

    func testPart1() {
        XCTAssertEqual(day.part1(input), 388739)
    }

    func testPart2Sample() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(sampleInput)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 26984457539)
    }

    func testDay1Part2() {
        XCTAssertEqual(day.part2(input), 1741362314973)
    }
}
