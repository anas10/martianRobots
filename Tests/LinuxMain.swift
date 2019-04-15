import XCTest

import martianRobotsTests

var tests = [XCTestCaseEntry]()
tests += martianRobotsTests.allTests()
XCTMain(tests)