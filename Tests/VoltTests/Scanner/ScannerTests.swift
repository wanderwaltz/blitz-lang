import XCTest
@testable import Volt

final class ScannerTests: XCTestCase {}

// MARK: - types
extension ScannerTests {
    func test__type__single_plus() {
        expect_source("+", scanned_types: ["+"])
    }

    func test__type__single_minus() {
        expect_source("-", scanned_types: ["-"])
    }

    func test__type__single_star() {
        expect_source("*", scanned_types: ["*"])
    }

    func test__type__single_slash() {
        expect_source("/", scanned_types: ["/"])
    }

    func test__type__mixed_plus_minus_star_slash() {
        expect_source(
            "+-*/---+++**/+--///****",
            scanned_types: ["+","-","*","/","-","-","-","+","+","+","*","*","/","+","-","-","/","/","/","*","*","*","*"])
    }

    func test__type__single_integer_literal() {
        expect_source("123", scanned_types: ["$num"])
    }

    func test__type__single_float_literal() {
        expect_source("0.345", scanned_types: ["$num"])
    }

    func test__type__whitespaces() {
        expect_source("  98  +   - *   /   4.56  ", scanned_types: ["$num", "+", "-", "*", "/", "$num"])
    }
}


// MARK: - lexemes
extension ScannerTests {
    func test__lexeme__single_plus() {
        expect_source("+", scanned_lexemes: ["+"])
    }

    func test__lexeme__single_minus() {
        expect_source("-", scanned_lexemes: ["-"])
    }

    func test__lexeme__single_star() {
        expect_source("*", scanned_lexemes: ["*"])
    }

    func test__lexeme__single_slash() {
        expect_source("/", scanned_lexemes: ["/"])
    }

    func test__lexeme__mixed_plus_minus_star_slash() {
        expect_source(
            "+-*/---+++**/+--///****",
            scanned_lexemes: ["+","-","*","/","-","-","-","+","+","+","*","*","/","+","-","-","/","/","/","*","*","*","*"])
    }

    func test__lexeme__single_integer_literal() {
        expect_source("123", scanned_lexemes: ["123"])
    }

    func test__lexeme__single_float_literal() {
        expect_source("0.345", scanned_lexemes: ["0.345"])
    }

    func test__lexeme__whitespaces() {
        expect_source("  98  +   - *   /   4.56  ", scanned_lexemes: ["98", "+", "-", "*", "/", "4.56"])
    }
}


// MARK: - errors
extension ScannerTests {
    func test__unexpected_token__error_code() {
        expect_error_scanning("±") { error in
            XCTAssertEqual(error.code, .unexpectedToken)
        }
    }

    func test__unexpected_token__error_line__case_0() {
        expect_error_scanning("±") { error in
            XCTAssertEqual(error.line, 0)
        }
    }

    func test__unexpected_token__error_line__case_1() {
        expect_error_scanning("+\n±") { error in
            XCTAssertEqual(error.line, 1)
        }
    }

    func test__unexpected_token__error_position__case_0() {
        expect_error_scanning("±") { error in
            XCTAssertEqual(error.line, 0)
        }
    }

    func test__unexpected_token__error_position__case_1() {
        expect_error_scanning("+±") { error in
            XCTAssertEqual(error.position, 1)
        }
    }

    func test__unexpected_token__error_location() {
        expect_error_scanning("+\n+±") { error in
            XCTAssertEqual(error.line, 1)
            XCTAssertEqual(error.position, 1)
        }
    }
}


private func expect_source(_ source: String,
                           scanned_types expectedDescriptions: [String],
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

private func expect_source(_ source: String,
                           scanned_lexemes expectedLexemes: [String],
                           file: StaticString = #file,
                           line: UInt = #line) {

    do {
        let tokens = try Scanner().process(source)
        let lexemes = tokens.map({ $0.lexeme })

        XCTAssertEqual(lexemes, expectedLexemes, file: file, line: line)
    }
    catch let error {
        XCTFail("scanner returned error: \(error)", file: file, line: line)
    }
}

private func expect_error_scanning(_ source: String,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   do block: (ScannerError) -> Void) {
    do {
        _ = try Scanner().process(source)
        XCTFail("expected an error scanning source", file: file, line: line)
    }
    catch let error {
        guard let scannerError = error as? ScannerError else {
            XCTFail("expected a ScannerError", file: file, line: line)
            return
        }

        block(scannerError)
    }
}
