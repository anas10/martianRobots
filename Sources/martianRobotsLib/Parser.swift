//
//  Parser.swift
//  martianRobots
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

public protocol ParserType {
    var mars: Mars { get }

    func parseInput()
}

public class Parser: ParserType {

    public var mars: Mars = Mars()

    // This is required to make this class usuable and testable outside the module
    public init() {}

    /**
     Parses the input string while validating the data then stores it if successful

     This function will print errors if any
     */
    public func parseInput() {
        mars = Mars()

        let inputData = getInputData()

        // Check that there is at least 3 lines (coordinates, one robot)
        guard inputData.count >= 3 else {
            printError("Invalid data : at least 3 lines required \(inputData)")
            return
        }

        getUpperRightCoordinates(inputData)
            .onCompletion {
                mars.world.right = $0.right
                mars.world.top = $0.top
        }

        getRobots(inputData)
            .onCompletion { mars.robots = $0 }
    }


    // MARK: - Get methods

    /**
     Parse robot data

     This function will print errors if any

     - parameters:
        - data: an array of data to parse

     - returns: An array of Robot elements on success or an error if the validation fails.
     */
    func getRobots(_ data: [String]) -> Result<[Robot]> {
        // Check that we have two lines per robot
        let count = data.count
        guard count >= 3, (count - 1) % 2 == 0 else {
            return .failure(ParsingError.robotIncomplete)
        }

        var robots: [Robot] = []

        var index = 1
        repeat {
            let robotPosition = data[index]
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")

            let instructionsData = data[index + 1]
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if validCoordinate(value: robotPosition[0]) &&
                validCoordinate(value: robotPosition[1]) &&
                validOrientation(value: robotPosition[2]) &&
                validInstructions(value: instructionsData) {

                let x = Int(robotPosition[0])!
                let y = Int(robotPosition[1])!
                let orientation = Orientation(rawValue: String(robotPosition[2]))!
                let instructions = instructionsData.map { String($0) }

                let robot = Robot(position: Position(x: x, y: y, orientation: orientation),
                                  instructions: instructions)
                robots.append(robot)
            } else {
                return .failure(ParsingError.robotInvalidData)
            }

            index += 2

        } while index < data.count

        return .success(robots)
    }

    /**
     Parse world coordinates

     This function will print errors if any

     - parameters:
        - data: an array of data to parse

     - returns: An tuple of coordinates on success or an error if the validation fails.
     */
    func getUpperRightCoordinates(_ data: [String]) -> Result<(right: Int, top: Int)> {
        let upperRight = data[0].split(separator: " ")

        // Check that we have only two elements
        guard upperRight.count == 2 else { return .failure(ParsingError.areaIncomplete) }

        // Validate every coordinate
        for coordinate in upperRight {
            guard validCoordinate(value: coordinate) else { return .failure(ParsingError.coordinateInvalid) }
        }

        let right = Int(upperRight[0])!
        let top = Int(upperRight[1])!

        return .success((right: right, top: top))
    }

    //MARK: - Validation
    private func validOrientation(value: Substring) -> Bool {
        let charset = CharacterSet(charactersIn: "NSEW")
        return value.rangeOfCharacter(from: charset.inverted) == nil
    }

    private func validInstructions(value: String) -> Bool {
        let charset = CharacterSet(charactersIn: "LRF")
        return value.rangeOfCharacter(from: charset.inverted) == nil &&
            value.count < 100
    }

    private func validCoordinate(value: Substring) -> Bool {
        if let num = Int(value), num <= 50 {
            return true
        }
        return false
    }

    //MARK: - Input
    private func getInputData() -> [String] {
        var inputData: [String] = []

        while let line = readLine() {
            guard line != "" else { break }

            inputData.append(line)
        }

        return inputData
    }
}
