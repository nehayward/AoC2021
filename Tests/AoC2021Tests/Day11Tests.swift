import XCTest
import AoC2021

final class Day11Tests: XCTestCase {
    let day = Day11()
    var inputName: String {"\(Self.self)"}
    var inputFileName: String { "input\(inputName.dropLast(5))"}

    let sampleInput = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
    var input: String {
        let url = Bundle.module.url(forResource: inputFileName, withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        return input
    }

    func testPart1Sample() {
        XCTAssertEqual(day.part1(sampleInput), 1656)
    }

    func testPart1() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part1(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 1757)
    }

    func testPart2Sample() {
        XCTAssertEqual(day.part2(sampleInput), 195)
    }

    func testDay1Part2() {
        let start = CFAbsoluteTimeGetCurrent()
        let answer = day.part2(input)
        let endTime = CFAbsoluteTimeGetCurrent()
        print(endTime - start)
        XCTAssertEqual(answer, 422)
    }
}
