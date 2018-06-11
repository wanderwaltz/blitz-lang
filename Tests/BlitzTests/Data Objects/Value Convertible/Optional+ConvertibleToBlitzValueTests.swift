import XCTest
@testable import Blitz

final class OptionalConvertibleToBlitzValueTests: XCTestCase {
    func test_optional_int_to_value() {
        validate_optional_convertible(0, to: .number(0))
        validate_optional_convertible(123, to: .number(123))
        validate_optional_convertible(100500, to: .number(100500))
        validate_optional_convertible(-42, to: .number(-42))
        validate_optional_convertible(Optional<Int>.none, to: .nil)
    }

    func test_optional_double_to_value() {
        validate_optional_convertible(0.0, to: .number(0.0))
        validate_optional_convertible(123.45, to: .number(123.45))
        validate_optional_convertible(-500.0, to: .number(-500.0))
        validate_optional_convertible(Optional<Double>.none, to: .nil)
    }

    func test_optional_string_to_value() {
        validate_optional_convertible("", to: .string(""))
        validate_optional_convertible("qwerty", to: .string("qwerty"))
        validate_optional_convertible(Optional<String>.none, to: .nil)
    }

    func test_optional_bool_to_value() {
        validate_optional_convertible(true, to: .bool(true))
        validate_optional_convertible(false, to: .bool(false))
        validate_optional_convertible(Optional<Bool>.none, to: .nil)
    }

    func test_optional_array_of_ints_to_value() {
        validate_optional_convertible([1, 2, 3], to: .array([.number(1), .number(2), .number(3)]))
        validate_optional_convertible([Int](), to: .array([]))
        validate_optional_convertible(Optional<[Int]>.none, to: .nil)
    }

    func test_optional_mixed_array_to_value() {
        validate_optional_convertible(
            [1, 2.3, "qwerty", false] as [Any],
            to: .array([.number(1), .number(2.3), .string("qwerty"), .bool(false)])
        )

        validate_optional_convertible(Optional<[Any]>.none, to: .nil)
    }

    private func validate_optional_convertible<T>(_ optional: T?, to value: Value, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(optional.blitzValue, value, file: file, line: line)
    }
}
