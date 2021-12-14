import Foundation

public class Day3 {
    public init() {

    }


    /// Calculate power consumption
    /// - Parameter input: An array of bitnumbers
    /// - Returns: Power consumption, gamma * epsilon
    public func part1(_ input: String) -> Int {
        let bitNumbers = input.split(whereSeparator: \.isNewline).map(String.init)
        let bitLength = bitNumbers[0].count

        var common = [(Int, Int)].init(repeating: (0, 0), count: bitLength)

        for (row, bitNumber) in bitNumbers.enumerated() {
            for (col, bit) in bitNumber.enumerated() {
                print(bit, col)
                if bit == "0" {
                    common[col].0 += 1
                } else {
                    common[col].1 += 1
                }
            }
        }

        var gammaRateInBit = ""
        var epsilonRateInBit = ""

        for c in common {
            if c.0 > c.1 {
                gammaRateInBit.append(contentsOf: "0")
                epsilonRateInBit.append(contentsOf: "1")

            } else {
                gammaRateInBit.append(contentsOf: "1")
                epsilonRateInBit.append(contentsOf: "0")
            }
        }

        print(gammaRateInBit)
        print(epsilonRateInBit)

        let gammaRate = Int(gammaRateInBit, radix: 2)!
        let epsilonRate = Int(epsilonRateInBit, radix: 2)!

        print(gammaRate)
        print(epsilonRate)

        return gammaRate * epsilonRate
    }


    /// Calculate life support rating, multiple oxygen generator rating by C02 scrubber rating.
    /// - Parameter input: list of bits
    /// - Returns: Life support rating.
    public func part2(_ input: String) -> Int {
        let bitNumbers = input.split(whereSeparator: \.isNewline).map(String.init)

        var col = 0
        var oxygenBits = oxygenRating(bitNumbers: bitNumbers, col: col)
        while oxygenBits.count != 1 {
            col += 1
            oxygenBits = oxygenRating(bitNumbers: oxygenBits, col: col)
        }

        print(oxygenBits)

        col = 0
        var C02ScrubberBits = C02Scrubber(bitNumbers: bitNumbers, col: col)
        while C02ScrubberBits.count != 1 {
            col += 1
            C02ScrubberBits = C02Scrubber(bitNumbers: C02ScrubberBits, col: col)
        }

        print(C02ScrubberBits)

//
        let oxygen = Int(oxygenBits.first!, radix: 2)!
        let C02Scrubber = Int(C02ScrubberBits.first!, radix: 2)!
//
        print(oxygen)
        print(C02Scrubber)
//
        return oxygen * C02Scrubber
    }

    private func calculate(bitNumbers: [String], col: Int) -> [(Int, Int)] {
        var common = [(Int, Int)].init(repeating: (0, 0), count: bitNumbers[0].count)
        for bitNumber in bitNumbers {
            let character = bitNumber[bitNumber.index(bitNumber.startIndex, offsetBy: col)]
            if character == "0" {
                common[col].0 += 1
            } else {
                common[col].1 += 1
            }
        }
        return common
    }

    private func oxygenRating(bitNumbers: [String], col: Int) -> [String] {
        let common = calculate(bitNumbers: bitNumbers, col: col)
        let c = common[col]
        if c.0 > c.1 {
            let bits = bitNumbers.compactMap { bitNumber -> String? in
                let character = bitNumber[bitNumber.index(bitNumber.startIndex, offsetBy: col)]
                print(character, bitNumber)
                if character == "0" {
                    return bitNumber
                }
                return nil
            }
            print(bits)
            return bits
        } else {
            let bits = bitNumbers.compactMap { bitNumber -> String? in
                let character = bitNumber[bitNumber.index(bitNumber.startIndex, offsetBy: col)]
                print(character, bitNumber)
                if character == "1" {
                    return bitNumber
                }
                return nil
            }
            print(bits)
            return bits
        }
    }

    private func C02Scrubber(bitNumbers: [String], col: Int) -> [String] {
        let common = calculate(bitNumbers: bitNumbers, col: col)
        let c = common[col]
        if c.0 <= c.1 {
            let bits = bitNumbers.compactMap { bitNumber -> String? in
                let character = bitNumber[bitNumber.index(bitNumber.startIndex, offsetBy: col)]
                print(character, bitNumber)
                if character == "0" {
                    return bitNumber
                }
                return nil
            }
            print(bits)
            return bits
        } else {
            let bits = bitNumbers.compactMap { bitNumber -> String? in
                let character = bitNumber[bitNumber.index(bitNumber.startIndex, offsetBy: col)]
                print(character, bitNumber)
                if character == "1" {
                    return bitNumber
                }
                return nil
            }
            print(bits)
            return bits
        }
    }
}
