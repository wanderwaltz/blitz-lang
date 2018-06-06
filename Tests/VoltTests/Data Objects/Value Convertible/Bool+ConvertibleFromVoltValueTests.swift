import XCTest
@testable import Volt

final class BoolConvertibleFromVoltValueTests: XCTestCase {
    func test_true_from_value() {
        verify_value(.bool(true), is_convertible_to: true)
        verify_value(.number(123), is_convertible_to: true)
        verify_value(.number(-1), is_convertible_to: true)
        verify_value(.string("qwerty"), is_convertible_to: true)
        verify_value(.array([.number(123), .string("qwerty")]), is_convertible_to: true)
    }

    func test_false_from_value() {
        verify_value(.bool(false), is_convertible_to: false)
        verify_value(.number(0), is_convertible_to: false)
        verify_value(.string(""), is_convertible_to: false)
        verify_value(.nil, is_convertible_to: false)
        verify_value(.array([]), is_convertible_to: false)
    }

    private func verify_value(_ value: Value, is_convertible_to bool: Bool, file: StaticString = #file, line: UInt = #line) {
        let any = Bool.fromVoltValue(value)
        XCTAssertEqual(typecast<Bool>.any(any), bool, file: file, line: line)
    }
}
