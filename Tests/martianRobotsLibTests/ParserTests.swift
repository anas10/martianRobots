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

    func testExample() {
        XCTAssertTrue(true)
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
