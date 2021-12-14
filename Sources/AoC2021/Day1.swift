extension AoC2021 {
    public func day1(_ input: [Int]) {
        var previous: Int?
        var increaseCount: Int = 0

        for depth in input {
            guard let currentPrevious = previous else {
                previous = depth
                continue
            }

            if depth > currentPrevious {
                increaseCount += 1
            }

            previous = depth
        }

        print(increaseCount)
    }

    public func day1_part2(_ input: [Int]) {
        var increaseCount = 0

        for (index, _) in input.enumerated() {
            let aStart = index - 3

            guard aStart >= 0 else { continue }

            // windowA
            print(input[aStart...index-1])

            // windowB
            print(input[aStart+1...index])

            let windowASum = input[aStart...index-1].reduce(0, +)
            let windowBSum = input[aStart+1...index].reduce(0, +)

            if windowBSum > windowASum {
                increaseCount += 1
            }

            print(increaseCount)
        }
    }
}
