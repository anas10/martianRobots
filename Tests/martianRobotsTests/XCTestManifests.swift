import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(martianRobotsTests.allTests),
        testCase(ParserTests.allTests)
    ]
}
#endif
