import Foundation
import AppKit

public class Day4 {
    public init() {

    }


    public func part1(_ input: String) -> Int {
        let lines = input.split(whereSeparator: \.isNewline)
        let bingoSequence = lines[0].split(separator: ",").map(String.init)

        var boards = [Board]()

        for index in stride(from: 1, to: lines.count, by: 5) {
            print(lines[index...index+4])
            var newBoard = Board()
            for rowNumber in index...index+4 {
                let row = lines[rowNumber].split(whereSeparator: \.isWhitespace).map(String.init).map(BoardPiece.init)
                newBoard.append(row)
            }
            boards.append(newBoard)
        }

        print(boards)


        boards[0][0][0].isMarked = true
        print(boards)

        let board = checkBoard(board: boards[0])
        print(board)
        var winningNumber: String = ""
        var winningBoardNumber: Int = 0

    outerLoop: for bingoSequence in bingoSequence {
        for (index, board) in boards.enumerated() {
            boards[index] = markBoard(board: board, value: bingoSequence)
            print(board)
            let winningSequence = checkBoard(board: boards[index])
            if !winningSequence.isEmpty {
                winningNumber = bingoSequence
                winningBoardNumber = index
                break outerLoop
            }
        }
    }

        print(winningNumber)
        print(winningBoardNumber)

        let allUnmarkedSum = boards[winningBoardNumber].flatMap { $0 }.filter(\.isNotMarked).map { $0.value }.compactMap(Int.init).reduce(0, +)
        print(allUnmarkedSum)
        return allUnmarkedSum * Int(winningNumber)!
    }



    /// Calculate last winner
    public func part2(_ input: String) -> Int {
        let lines = input.split(whereSeparator: \.isNewline)
        let bingoSequence = lines[0].split(separator: ",").map(String.init)

        var boards = [Board]()
        for index in stride(from: 1, to: lines.count, by: 5) {
            print(lines[index...index+4])
            var newBoard = Board()
            for rowNumber in index...index+4 {
                let row = lines[rowNumber].split(whereSeparator: \.isWhitespace).map(String.init).map(BoardPiece.init)
                newBoard.append(row)
            }
            boards.append(newBoard)
        }

        print(boards)
        var boardWinners = [Bool].init(repeating: false, count: boards.count)


        boards[0][0][0].isMarked = true
        print(boards)

        let board = checkBoard(board: boards[0])
        print(board)
        var winningNumber: String = ""
        var winningBoardNumber: Int = 0

    outerLoop: for bingoSequence in bingoSequence {
        for (index, board) in boards.enumerated() {
            boards[index] = markBoard(board: board, value: bingoSequence)
            print(board)
            let winningSequence = checkBoard(board: boards[index])
            if !winningSequence.isEmpty && !boardWinners[index] {
                print(index)
                boardWinners[index] = true
                if boardWinners.allSatisfy { $0 == true } {
                    print("Last winner")
                    print(index)
                    winningNumber = bingoSequence
                    winningBoardNumber = index
                    break outerLoop
                }
            }
        }
    }

        print(winningNumber)
        print(winningBoardNumber)

        let allUnmarkedSum = boards[winningBoardNumber].flatMap { $0 }.filter(\.isNotMarked).map { $0.value }.compactMap(Int.init).reduce(0, +)
        print(allUnmarkedSum)
        return allUnmarkedSum * Int(winningNumber)!
    }

    private func checkBoard(board: Board) -> [String] {
        for row in board {
            if row.allSatisfy(\.isMarked) {
                return row.map(\.value)
            }
            print(row)
        }

        for (colIndex, _) in board.enumerated() {
            var col = [BoardPiece]()
            for i in 0...4 {
                col.append(board[i][colIndex])
            }
            if col.allSatisfy(\.isMarked) {
                return col.map(\.value)
            }
        }

        return []
    }

    private func markBoard(board: Board, value: String) -> Board {
        var board = board
        for row in board.enumerated() {
            for col in row.element.enumerated() {
                if col.element.value == value {
                    board[row.offset][col.offset].isMarked = true
                }
            }
        }

        return board
    }
}

extension Day4 {
    typealias Board = [[BoardPiece]]

    struct BoardPiece: CustomStringConvertible {
        var description: String { "\(isMarked ? "(\(value))" : value)"}

        var value: String
        var isMarked: Bool

        init(_ value: String) {
            self.value = value
            self.isMarked = false
        }

        var isNotMarked: Bool { !isMarked }
    }
}
