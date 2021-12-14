import XCTest
import AoC2021

final class AoC2021Day2Tests: XCTestCase {
    let day2 = Day2()

    func testPart1Sample() {
        let input = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""
        XCTAssertEqual(day2.part1(input), 150)
    }

    func testPart1() {
        let url = Bundle.module.url(forResource: "inputDay2", withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        XCTAssertEqual(day2.part1(input), 1714950)
    }

    func testPart2Sample() {
        let input = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""
        XCTAssertEqual(day2.part2(input), 900)
    }

    func testDay1Part2() {
        let url = Bundle.module.url(forResource: "inputDay2", withExtension: "txt")!
        let input = try! String(contentsOf: url, encoding: .utf8)
        XCTAssertEqual(day2.part2(input), 1281977850)
    }
}
