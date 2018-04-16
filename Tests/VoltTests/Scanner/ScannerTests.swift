import XCTest
@testable import Volt

final class ScannerTests: XCTestCase {
    func testSinglePlus() {
        expect_source("+", scanned_into: ["+"])
    }

    func testSingleMinus() {
        expect_source("-", scanned_into: ["-"])
    }

    static var allTests = [
        ("testSinglePlus", testSinglePlus),
        ("testSingleMinus", testSingleMinus),
    ]
}


private func expect_source(_ source: String,
                           scanned_into expectedDescriptions: [String],
                           file: StaticString = #file,
                           line: UInt = #line) {
    let tokens = Scanner().process(source)
    let types = tokens.map({ $0.type })
    let descriptions = types.map({ $0.description })

    XCTAssertEqual(descriptions, expectedDescriptions, file: file, line: line)
}
