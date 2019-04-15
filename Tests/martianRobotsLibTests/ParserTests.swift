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
        XCTAssertTrue(parser.getUpperRightCoordinates(["5 3"]))
        XCTAssertFalse(parser.getUpperRightCoordinates(["51 3"]))
        XCTAssertFalse(parser.getUpperRightCoordinates(["5"]))
    }

    func testGetRobots() {
        let oneRobot = ["5 3", "1 1 E", "RFRFRFRF"]
        XCTAssertTrue(parser.getRobots(oneRobot))
        XCTAssertEqual(parser.mars.robots.count, 1)

        let noRobot = ["5 3"]
        XCTAssertFalse(parser.getRobots(noRobot))

        let emptyData: [String] = []
        XCTAssertFalse(parser.getRobots(emptyData))

        let maxCoordinateRobotData = ["5 3", "100 1 E", "RFRFRFRF"]
        XCTAssertFalse(parser.getRobots(maxCoordinateRobotData))

        let invalidInstructionRobotData = ["5 3", "1 1 E", "RFARFRFRF"]
        XCTAssertFalse(parser.getRobots(invalidInstructionRobotData))

        let invalidOrientation = ["5 3", "1 1 F", "RFRFRFRF"]
        XCTAssertFalse(parser.getRobots(invalidOrientation))

    }
    
    static var allTests = [
        ("testGetUpperRightCoordinates", testGetUpperRightCoordinates),
        ("testGetRobots", testGetRobots)
    ]
}
