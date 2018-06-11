import XCTest
@testable import Blitz

final class ArrayConvertibleFromBlitzValueTests: XCTestCase {
    func test_array_from_homogenous_value() {
        verify_value(
            .array([.bool(true), .bool(true), .bool(false)]),
            is_convertible_to: [true, true, false]
        )

        verify_value(
            .array([.number(-1), .number(100), .number(500), .number(1000)]),
            is_convertible_to: [-1, 100, 500, 1000]
        )

        verify_value(
            .array([.string("a"), .string("b")]),
            is_convertible_to: ["a", "b"]
        )
    }

    func test_array_from_heterogenous_value() {
        verify_value(
            .array([.number(-1), .string("asdfg")]),
            is_NOT_convertible_to: [Int].self
        )

        verify_value(
            .array([.number(-1), .string("asdfg")]),
            is_NOT_convertible_to: [String].self
        )
    }

    private func verify_value<T: Equatable>(_ value: Value, is_convertible_to array: [T], file: StaticString = #file, line: UInt = #line) {
        let any = [T].fromBlitzValue(value)
        XCTAssertEqual(typecast<[T]>.any(any), array, file: file, line: line)
    }

    private func verify_value<T: Equatable>(_ value: Value, is_NOT_convertible_to type: [T].Type, file: StaticString = #file, line: UInt = #line) {
        let any = [T].fromBlitzValue(value)
        XCTAssertNil(any, file: file, line: line)
    }
}
