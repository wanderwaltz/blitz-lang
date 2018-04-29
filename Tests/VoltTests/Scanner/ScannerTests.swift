import XCTest
@testable import Volt

final class ScannerTests: XCTestCase {}

// MARK: - types
extension ScannerTests {
    // MARK: single-character tokens
    func test__type__single_left_paren() {
        expect_source("(", scanned_types: ["("])
    }

    func test__type__single_right_paren() {
        expect_source(")", scanned_types: [")"])
    }

    func test__type__single_left_brace() {
        expect_source("{", scanned_types: ["{"])
    }

    func test__type__single_right_brace() {
        expect_source("}", scanned_types: ["}"])
    }

    func test__type__single_comma() {
        expect_source(",", scanned_types: [","])
    }

    func test__type__single_dot() {
        expect_source(".", scanned_types: ["."])
    }

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
            "+-*/---+++**/+--/ / /****",
            scanned_types: ["+","-","*","/","-","-","-","+","+","+","*","*","/","+","-","-","/","/","/","*","*","*","*"])
    }

    // MARK: one or two character tokens
    func test__type__single_bang() {
        expect_source("!", scanned_types: ["!"])
    }

    func test__type__single_bangEqual() {
        expect_source("!=", scanned_types: ["!="])
    }

    func test__type__single_equal() {
        expect_source("=", scanned_types: ["="])
    }

    func test__type__single_equalEqual() {
        expect_source("==", scanned_types: ["=="])
    }

    func test__type__single_greater() {
        expect_source(">", scanned_types: [">"])
    }

    func test__type__single_greaterEqual() {
        expect_source(">=", scanned_types: [">="])
    }

    func test__type__single_less() {
        expect_source("<", scanned_types: ["<"])
    }

    func test__type__single_lessEqual() {
        expect_source("<=", scanned_types: ["<="])
    }

    // MARK: literals
    func test__type__single_integer_literal() {
        expect_source("123", scanned_types: ["$num"])
    }

    func test__type__single_float_literal() {
        expect_source("0.345", scanned_types: ["$num"])
    }

    func test__type__single_string_literal() {
        expect_source("\"qwerty\"", scanned_types: ["$str"])
    }

    func test__type__whitespaces() {
        expect_source("  98  +   - *   /   4.56  ", scanned_types: ["$num", "+", "-", "*", "/", "$num"])
    }

    // MARK: identifiers
    func test__type__single_identifier_case_0() {
        expect_source("qwerty", scanned_types: ["$id"])
    }

    func test__type__single_identifier_case_1() {
        expect_source("q1wert2y345", scanned_types: ["$id"])
    }

    func test__type__single_identifier_case_2() {
        expect_source("_qwerty", scanned_types: ["$id"])
    }

    // MARK: keywords
    func test__type__single_keyword_and() {
        expect_source("and", scanned_types: ["and"])
    }

    func test__type__single_keyword_class() {
        expect_source("class", scanned_types: ["class"])
    }

    func test__type__single_keyword_else() {
        expect_source("else", scanned_types: ["else"])
    }

    func test__type__single_keyword_false() {
        expect_source("false", scanned_types: ["false"])
    }

    func test__type__single_keyword_func() {
        expect_source("func", scanned_types: ["func"])
    }

    func test__type__single_keyword_for() {
        expect_source("for", scanned_types: ["for"])
    }

    func test__type__single_keyword_if() {
        expect_source("if", scanned_types: ["if"])
    }

    func test__type__single_keyword_nil() {
        expect_source("nil", scanned_types: ["nil"])
    }

    func test__type__single_keyword_or() {
        expect_source("or", scanned_types: ["or"])
    }

    func test__type__single_keyword_not() {
        expect_source("not", scanned_types: ["not"])
    }

    func test__type__single_keyword_return() {
        expect_source("return", scanned_types: ["return"])
    }

    func test__type__single_keyword_super() {
        expect_source("super", scanned_types: ["super"])
    }

    func test__type__single_keyword_self() {
        expect_source("self", scanned_types: ["self"])
    }

    func test__type__single_keyword_true() {
        expect_source("true", scanned_types: ["true"])
    }

    func test__type__single_keyword_let() {
        expect_source("let", scanned_types: ["let"])
    }

    func test__type__single_keyword_var() {
        expect_source("var", scanned_types: ["var"])
    }

    func test__type__single_keyword_while() {
        expect_source("while", scanned_types: ["while"])
    }
}


// MARK: - lexemes
extension ScannerTests {
    // MARK: single-character tokens
    func test__lexeme__single_left_paren() {
        expect_source("(", scanned_lexemes: ["("])
    }

    func test__lexeme__single_right_paren() {
        expect_source(")", scanned_lexemes: [")"])
    }

    func test__lexeme__single_left_brace() {
        expect_source("{", scanned_lexemes: ["{"])
    }

    func test__lexeme__single_right_brace() {
        expect_source("}", scanned_lexemes: ["}"])
    }

    func test__lexeme__single_comma() {
        expect_source(",", scanned_lexemes: [","])
    }

    func test__lexeme__single_dot() {
        expect_source(".", scanned_lexemes: ["."])
    }

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
            "+-*/---+++**/+--/ / /****",
            scanned_lexemes: ["+","-","*","/","-","-","-","+","+","+","*","*","/","+","-","-","/","/","/","*","*","*","*"])
    }

    // MARK: one or two character tokens
    func test__lexeme__single_bang() {
        expect_source("!", scanned_lexemes: ["!"])
    }

    func test__lexeme__single_bangEqual() {
        expect_source("!=", scanned_lexemes: ["!="])
    }

    func test__lexeme__single_equal() {
        expect_source("=", scanned_lexemes: ["="])
    }

    func test__lexeme__single_equalEqual() {
        expect_source("==", scanned_lexemes: ["=="])
    }

    func test__lexeme__single_greater() {
        expect_source(">", scanned_lexemes: [">"])
    }

    func test__lexeme__single_greaterEqual() {
        expect_source(">=", scanned_lexemes: [">="])
    }

    func test__lexeme__single_less() {
        expect_source("<", scanned_lexemes: ["<"])
    }

    func test__lexeme__single_lessEqual() {
        expect_source("<=", scanned_lexemes: ["<="])
    }

    // MARK: literals
    func test__lexeme__single_integer_literal() {
        expect_source("123", scanned_lexemes: ["123"])
    }

    func test__lexeme__single_float_literal() {
        expect_source("0.345", scanned_lexemes: ["0.345"])
    }

    func test__lexeme__single_string_literal() {
        expect_source("\"qwerty\"", scanned_lexemes: ["\"qwerty\""])
    }

    func test__lexeme__whitespaces() {
        expect_source("  98  +   - *   /   4.56  ", scanned_lexemes: ["98", "+", "-", "*", "/", "4.56"])
    }

    // MARK: identifiers
    func test__lexeme__single_identifier_case_0() {
        expect_source("qwerty", scanned_lexemes: ["qwerty"])
    }

    func test__lexeme__single_identifier_case_1() {
        expect_source("q1wert2y345", scanned_lexemes: ["q1wert2y345"])
    }

    func test__lexeme__single_identifier_case_2() {
        expect_source("_qwerty", scanned_lexemes: ["_qwerty"])
    }

    // MARK: keywords
    func test__lexeme__single_keyword_and() {
        expect_source("and", scanned_lexemes: ["and"])
    }

    func test__lexeme__single_keyword_class() {
        expect_source("class", scanned_lexemes: ["class"])
    }

    func test__lexeme__single_keyword_else() {
        expect_source("else", scanned_lexemes: ["else"])
    }

    func test__lexeme__single_keyword_false() {
        expect_source("false", scanned_lexemes: ["false"])
    }

    func test__lexeme__single_keyword_func() {
        expect_source("func", scanned_lexemes: ["func"])
    }

    func test__lexeme__single_keyword_for() {
        expect_source("for", scanned_lexemes: ["for"])
    }

    func test__lexeme__single_keyword_if() {
        expect_source("if", scanned_lexemes: ["if"])
    }

    func test__lexeme__single_keyword_nil() {
        expect_source("nil", scanned_lexemes: ["nil"])
    }

    func test__lexeme__single_keyword_or() {
        expect_source("or", scanned_lexemes: ["or"])
    }

    func test__lexeme__single_keyword_not() {
        expect_source("not", scanned_lexemes: ["not"])
    }

    func test__lexeme__single_keyword_return() {
        expect_source("return", scanned_lexemes: ["return"])
    }

    func test__lexeme__single_keyword_super() {
        expect_source("super", scanned_lexemes: ["super"])
    }

    func test__lexeme__single_keyword_self() {
        expect_source("self", scanned_lexemes: ["self"])
    }

    func test__lexeme__single_keyword_true() {
        expect_source("true", scanned_lexemes: ["true"])
    }

    func test__lexeme__single_keyword_let() {
        expect_source("let", scanned_lexemes: ["let"])
    }

    func test__lexeme__single_keyword_var() {
        expect_source("var", scanned_lexemes: ["var"])
    }

    func test__lexeme__single_keyword_while() {
        expect_source("while", scanned_lexemes: ["while"])
    }
}


// MARK: - literal values
extension ScannerTests {
    func test__number_literal__integer_value() {
        XCTAssertEqual(scan("123.456").first?.numberValue, 123.456)
    }

    func test__number_literal__string_value() {
        XCTAssertEqual(scan("123.456").first?.stringValue, "123.456")
    }

    func test__string_literal__string_value() {
        XCTAssertEqual(scan("\"qwerty\"").first?.stringValue, "qwerty")
    }

    func test__string_literal__number_value_valid() {
        XCTAssertEqual(scan("\"123.456\"").first?.numberValue, 123.456)
    }

    func test__string_literal__number_value_invalid() {
        XCTAssertNil(scan("\"qwerty\"").first?.numberValue)
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
            XCTAssertEqual(error.location.line, 0)
        }
    }

    func test__unexpected_token__error_line__case_1() {
        expect_error_scanning("+\n±") { error in
            XCTAssertEqual(error.location.line, 1)
        }
    }

    func test__unexpected_token__error_position__case_0() {
        expect_error_scanning("±") { error in
            XCTAssertEqual(error.location.line, 0)
        }
    }

    func test__unexpected_token__error_position__case_1() {
        expect_error_scanning("+±") { error in
            XCTAssertEqual(error.location.offset, 1)
        }
    }

    func test__unexpected_token__error_location() {
        expect_error_scanning("+\n+±") { error in
            XCTAssertEqual(error.location.line, 1)
            XCTAssertEqual(error.location.offset, 1)
        }
    }
}


private func scan(_ source: String, file: StaticString = #file, line: UInt = #line) -> [Token] {
    do {
        let tokens = try Scanner().process(source)
        return tokens
    }
    catch let error {
        XCTFail("scanner returned error: \(error)", file: file, line: line)
        return []
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
