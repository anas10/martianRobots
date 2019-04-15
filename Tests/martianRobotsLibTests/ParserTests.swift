//
//  ParserTests.swift
//  martianRobotsTests
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import XCTest
@testable import martianRobotsLib

class ParserTests: XCTestCase {

    var parser: Parser!

    override func setUp() {
        parser = Parser()
    }

    func testGetUpperRightCoordinates() {
        XCTAssertTrue(parser.getUpperRightCoordinates(["5 3"]).isSuccessful())
        XCTAssertFalse(parser.getUpperRightCoordinates(["51 3"]).isSuccessful())
        XCTAssertFalse(parser.getUpperRightCoordinates(["5"]).isSuccessful())
    }

    func testGetRobots() {
        let oneRobot = ["5 3", "1 1 E", "RFRFRFRF"]
        let subject = parser.getRobots(oneRobot)

        subject.onCompletion {
            XCTAssertEqual($0.count, 1)
        }

        XCTAssertTrue(subject.isSuccessful())

        let noRobot = ["5 3"]
        XCTAssertFalse(parser.getRobots(noRobot).isSuccessful())

        let emptyData: [String] = []
        XCTAssertFalse(parser.getRobots(emptyData).isSuccessful())

        let maxCoordinateRobotData = ["5 3", "100 1 E", "RFRFRFRF"]
        XCTAssertFalse(parser.getRobots(maxCoordinateRobotData).isSuccessful())

        let invalidInstructionRobotData = ["5 3", "1 1 E", "RFARFRFRF"]
        XCTAssertFalse(parser.getRobots(invalidInstructionRobotData).isSuccessful())

        let invalidOrientation = ["5 3", "1 1 F", "RFRFRFRF"]
        XCTAssertFalse(parser.getRobots(invalidOrientation).isSuccessful())

    }
    
    static var allTests = [
        ("testGetUpperRightCoordinates", testGetUpperRightCoordinates),
        ("testGetRobots", testGetRobots)
    ]
}
