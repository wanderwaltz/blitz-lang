import XCTest
@testable import Blitz

final class StringConvertibleFromBlitzValueTests: XCTestCase {
    func test_string_from_value() {
        validate_value(.string(""), is_convertible_to: "")
        validate_value(.string("qwerty"), is_convertible_to: "qwerty")
        validate_value(.bool(true), is_convertible_to: "true")
        validate_value(.bool(false), is_convertible_to: "false")
        validate_value(.number(0), is_convertible_to: "0")
        validate_value(.number(1), is_convertible_to: "1")
        validate_value(.number(100500), is_convertible_to: "100500")
        validate_value(.number(-42), is_convertible_to: "-42")
        validate_value(.number(100.500), is_convertible_to: "100.5")
        validate_value(.nil, is_convertible_to: "nil")

        validate_value(
            .array([.string("qwerty"), .number(123), .bool(true)]),
            is_convertible_to: "[qwerty, 123, true]"
        )
    }

    private func validate_value(_ value: Value, is_convertible_to string: String, file: StaticString = #file, line: UInt = #line) {
        let any = String.fromBlitzValue(value)
        XCTAssertEqual(string, typecast<String>.any(any), file: file, line: line)
    }
}
