//
//  Parser.swift
//  martianRobots
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

public protocol ParserType {
    func parseInput()
}

public class Parser: ParserType {

    var mars: Mars = Mars()

    // This is required to make this class usuable and testable outside the module
    public init() {}

    public func parseInput() {
        mars = Mars()

        let inputData = getInputData()

        // Check that there is at least 3 lines (coordinates, one robot)
        guard inputData.count >= 3 else {
            printError("Invalid data : at least 3 lines required \(inputData)")
            return
        }

        guard getUpperRightCoordinates(inputData) else {
            printError("Invalid upper right coordinates")
            return
        }

        guard getRobots(inputData) else {
            printError("Invalid robots data")
            return
        }

//        print(mars.debugDescription)
    }


    // MARK: - Get methods
    func getRobots(_ data: [String]) -> Bool {
        // Check that we have two lines per robot
        let count = data.count
        guard count >= 3, (count - 1) % 2 == 0 else {
            printError("2 lines per robot required")
            return false
        }

        var index = 1
        repeat {
            let robotPosition = data[index]
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")

            let instructionsData = data[index + 1]

            if validCoordinate(value: robotPosition[0]) &&
                validCoordinate(value: robotPosition[1]) &&
                validOrientation(value: robotPosition[2]) &&
                validInstructions(value: instructionsData) {

                let x = Int(robotPosition[0])!
                let y = Int(robotPosition[1])!
                let orientation = Orientation(rawValue: String(robotPosition[2]))!
                let instructions = instructionsData.map { String($0) }

                let robot = Robot(position: (x: x, y: y, orientation: orientation),
                                  instructions: instructions)
                mars.robots.append(robot)
            } else {
                return false
            }

            index += 2

        } while index < data.count

        return true
    }

    func getUpperRightCoordinates(_ data: [String]) -> Bool {
        let upperRight = data[0].split(separator: " ")

        // Check that we have only two elements
        guard upperRight.count == 2 else { return false }

        // Validate every coordinate
        for coordinate in upperRight {
            guard validCoordinate(value: coordinate) else { return false }
        }

        mars.world.top = Int(upperRight[0])!
        mars.world.right = Int(upperRight[1])!

        return true
    }

    private func validOrientation(value: Substring) -> Bool {
        let charset = CharacterSet(charactersIn: "NSEW")
        return value.rangeOfCharacter(from: charset.inverted) == nil
    }

    private func validInstructions(value: String) -> Bool {
        let charset = CharacterSet(charactersIn: "LRF")
        return value.rangeOfCharacter(from: charset.inverted) == nil
    }

    private func validCoordinate(value: Substring) -> Bool {
        if let num = Int(value), num <= 50 {
            return true
        }
        return false
    }

    private func getInputData() -> [String] {
        var inputData: [String] = []

        while let line = readLine() {
            guard line != "" else { break }

            inputData.append(line)
        }

        return inputData
    }
}
