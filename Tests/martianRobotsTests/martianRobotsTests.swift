import XCTest
import class Foundation.Bundle

final class martianRobotsTests: XCTestCase {
    func testSampleData() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let fooBinary = productsDirectory.appendingPathComponent("martianRobotsApp")

        let process = Process()
        process.executableURL = fooBinary

        let inputPipe = Pipe()
        process.standardInput = inputPipe

        let outputPipe = Pipe()
        process.standardOutput = outputPipe

        let errorPipe = Pipe()
        process.standardError = errorPipe

        try process.run()

        let sampleData = """
        5 3
        1 1 E
        RFRFRFRF
        3 2 N
        FRRFLLFFRRFLL
        0 3 W
        LLFFFLFLFL

        """

        let fh = inputPipe.fileHandleForWriting
        fh.write(sampleData.data(using: .utf8)!)
        fh.closeFile()

        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let errorOutput = String(data: errorData, encoding: .utf8)

        let expectedOutput = """
        Enter your instructions:
        1 1 E
        3 3 N LOST
        2 3 S

        """

        XCTAssertEqual(output, expectedOutput)
        XCTAssertEqual(errorOutput, "")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
        #else
        return Bundle.main.bundleURL
        #endif
    }

    static var allTests = [
        ("testSampleData", testSampleData)
    ]
}
