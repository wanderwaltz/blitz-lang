import XCTest
@testable import Volt

final class ScannerTests: XCTestCase {
    func test__single_plus() {
        expect_source("+", scanned_into: ["+"])
    }

    func test__single_minus() {
        expect_source("-", scanned_into: ["-"])
    }

    func test__single_star() {
        expect_source("*", scanned_into: ["*"])
    }

    func test__single_slash() {
        expect_source("/", scanned_into: ["/"])
    }

    func test__mixed_plus_minus_star_slash() {
        expect_source(
            "+-*/---+++**/+--///****",
            scanned_into: ["+","-","*","/","-","-","-","+","+","+","*","*","/","+","-","-","/","/","/","*","*","*","*"])
    }

    func test__whitespaces() {
        expect_source("    +   - *   /   ", scanned_into: ["+", "-", "*", "/"])
    }
}


private func expect_source(_ source: String,
                           scanned_into expectedDescriptions: [String],
                           file: StaticString = #file,
                           line: UInt = #line) {

    do {
        let tokens = try Scanner().process(source)
        let types = tokens.map({ $0.type })
        let descriptions = types.map({ $0.description })

        XCTAssertEqual(descriptions, expectedDescriptions, file: file, line: line)
    }
    catch let error {
        XCTFail("scanner returned error: \(error)", file: file, line: line)
    }
}
