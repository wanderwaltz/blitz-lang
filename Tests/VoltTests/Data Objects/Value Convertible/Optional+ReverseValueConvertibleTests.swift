import XCTest
@testable import Volt

final class OptionalReverseValueConvertibleTests: XCTestCase {
    func test_optional_int_from_value() {
        validate_value(.number(0), is_convertible_to: 0 as Int?)
        validate_value(.number(123), is_convertible_to: 123 as Int?)
        validate_value(.number(100500), is_convertible_to: 100500 as Int?)
        validate_value(.number(-42), is_convertible_to: -42 as Int?)
        validate_value(.nil, is_convertible_to: nil as Int?)

        validate_value(.bool(true), is_convertible_to: 1 as Int?)
        validate_value(.bool(false), is_convertible_to: 0 as Int?)

        validate_value(.number(1.5), is_convertible_to: 1 as Int?)
        validate_value(.number(-2.5), is_convertible_to: -2 as Int?)

        validate_value(.string(""), is_convertible_to: nil as Int?)
        validate_value(.string("qwerty"), is_convertible_to: nil as Int?)

    }

    func test_optional_double_from_value() {
        validate_value(.number(0.0), is_convertible_to: 0.0 as Double?)
        validate_value(.number(123.45), is_convertible_to: 123.45 as Double?)
        validate_value(.number(-500.0), is_convertible_to: -500.0 as Double?)
        validate_value(.nil, is_convertible_to: nil as Double?)

        validate_value(.number(100500), is_convertible_to: 100500 as Double?)
        validate_value(.number(-42), is_convertible_to: -42 as Double?)

        validate_value(.bool(true), is_convertible_to: 1.0 as Double?)
        validate_value(.bool(false), is_convertible_to: 0.0 as Double?)

        validate_value(.string("qwerty"), is_convertible_to: nil as Double?)
        validate_value(.string(""), is_convertible_to: nil as Double?)
    }

    func test_optional_string_from_value() {
        validate_value(.string("qwerty"), is_convertible_to: "qwerty" as String?)
        validate_value(.string(""), is_convertible_to: "" as String?)
        validate_value(.nil, is_convertible_to: nil as String?)

        validate_value(.number(0.0), is_convertible_to: "0" as String?)
        validate_value(.number(123.45), is_convertible_to: "123.45" as String?)
        validate_value(.number(-500.0), is_convertible_to: "-500" as String?)

        validate_value(.number(100500), is_convertible_to: "100500" as String?)
        validate_value(.number(-42), is_convertible_to: "-42" as String?)

        validate_value(.bool(true), is_convertible_to: "true" as String?)
        validate_value(.bool(false), is_convertible_to: "false" as String?)
    }

    func test_optional_bool_to_value() {
        validate_value(.bool(true), is_convertible_to: true as Bool?)
        validate_value(.bool(false), is_convertible_to: false as Bool?)
        validate_value(.nil, is_convertible_to: nil as Bool?)

        validate_value(.string("qwerty"), is_convertible_to: true as Bool?)
        validate_value(.string(""), is_convertible_to: false as Bool?)

        validate_value(.number(0.0), is_convertible_to: false as Bool?)
        validate_value(.number(123.45), is_convertible_to: true as Bool?)
        validate_value(.number(-500.0), is_convertible_to: true as Bool?)

        validate_value(.number(100500), is_convertible_to: true as Bool?)
        validate_value(.number(-42), is_convertible_to: true as Bool?)

    }
    
    private func validate_value<T: Equatable>(_ value: Value, is_convertible_to optional: Optional<T>, file: StaticString = #file, line: UInt = #line) {
        let any = Optional<T>.fromVoltValue(value)
        XCTAssertEqual(optional, typecast<T?>.any(any), file: file, line: line)
    }
}
