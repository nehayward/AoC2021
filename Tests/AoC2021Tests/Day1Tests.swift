import XCTest
import AoC2021

final class AoC2021Day1Tests: XCTestCase {
    let AoC = AoC2021()

    func testDay1Part1() {
        let url = Bundle.module.url(forResource: "inputDay1", withExtension: "txt")!

        guard let jsonString = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }

        let depths = jsonString.split(separator: "\n").map(String.init).compactMap(Int.init)
        AoC.day1(depths)
    }

    func testDay1Part2() {
        let url = Bundle.module.url(forResource: "inputDay1", withExtension: "txt")!

        guard let jsonString = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }

        var testInput = """
199
200
208
210
200
207
240
269
260
263
"""
        let depths = jsonString.split(separator: "\n").map(String.init).compactMap(Int.init)



        AoC.day1_part2(depths)
    }
}
