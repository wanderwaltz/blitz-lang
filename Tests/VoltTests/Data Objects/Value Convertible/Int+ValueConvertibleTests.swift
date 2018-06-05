// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Int
final class IntValueConvertibleTests: XCTestCase {
    func test_int_to_value() {
        validate_int_convertible(0)
        validate_int_convertible(1)
        validate_int_convertible(5)
        validate_int_convertible(127)
        validate_int_convertible(-42)
        validate_int_convertible(-127)
    }

    private func validate_int_convertible(_ int: Int, file: StaticString = #file, line: UInt = #line) {
        let value = int.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(int, Int(numberValue), file: file, line: line)

        default:
            XCTFail("expected Int to be convertible to .number")
        }
    }
}



// MARK: - Int8
final class Int8ValueConvertibleTests: XCTestCase {
    func test_int8_to_value() {
        validate_int8_convertible(0)
        validate_int8_convertible(1)
        validate_int8_convertible(5)
        validate_int8_convertible(127)
        validate_int8_convertible(-42)
        validate_int8_convertible(-127)
    }

    private func validate_int8_convertible(_ int8: Int8, file: StaticString = #file, line: UInt = #line) {
        let value = int8.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(int8, Int8(numberValue), file: file, line: line)

        default:
            XCTFail("expected Int8 to be convertible to .number")
        }
    }
}



// MARK: - Int32
final class Int32ValueConvertibleTests: XCTestCase {
    func test_int32_to_value() {
        validate_int32_convertible(0)
        validate_int32_convertible(1)
        validate_int32_convertible(5)
        validate_int32_convertible(127)
        validate_int32_convertible(-42)
        validate_int32_convertible(-127)
    }

    private func validate_int32_convertible(_ int32: Int32, file: StaticString = #file, line: UInt = #line) {
        let value = int32.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(int32, Int32(numberValue), file: file, line: line)

        default:
            XCTFail("expected Int32 to be convertible to .number")
        }
    }
}



// MARK: - Int64
final class Int64ValueConvertibleTests: XCTestCase {
    func test_int64_to_value() {
        validate_int64_convertible(0)
        validate_int64_convertible(1)
        validate_int64_convertible(5)
        validate_int64_convertible(127)
        validate_int64_convertible(-42)
        validate_int64_convertible(-127)
    }

    private func validate_int64_convertible(_ int64: Int64, file: StaticString = #file, line: UInt = #line) {
        let value = int64.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(int64, Int64(numberValue), file: file, line: line)

        default:
            XCTFail("expected Int64 to be convertible to .number")
        }
    }
}



// MARK: - UInt
final class UIntValueConvertibleTests: XCTestCase {
    func test_uint_to_value() {
        validate_uint_convertible(0)
        validate_uint_convertible(1)
        validate_uint_convertible(5)
        validate_uint_convertible(127)
    }

    private func validate_uint_convertible(_ uint: UInt, file: StaticString = #file, line: UInt = #line) {
        let value = uint.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(uint, UInt(numberValue), file: file, line: line)

        default:
            XCTFail("expected UInt to be convertible to .number")
        }
    }
}



// MARK: - UInt8
final class UInt8ValueConvertibleTests: XCTestCase {
    func test_uint8_to_value() {
        validate_uint8_convertible(0)
        validate_uint8_convertible(1)
        validate_uint8_convertible(5)
        validate_uint8_convertible(127)
    }

    private func validate_uint8_convertible(_ uint8: UInt8, file: StaticString = #file, line: UInt = #line) {
        let value = uint8.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(uint8, UInt8(numberValue), file: file, line: line)

        default:
            XCTFail("expected UInt8 to be convertible to .number")
        }
    }
}



// MARK: - UInt32
final class UInt32ValueConvertibleTests: XCTestCase {
    func test_uint32_to_value() {
        validate_uint32_convertible(0)
        validate_uint32_convertible(1)
        validate_uint32_convertible(5)
        validate_uint32_convertible(127)
    }

    private func validate_uint32_convertible(_ uint32: UInt32, file: StaticString = #file, line: UInt = #line) {
        let value = uint32.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(uint32, UInt32(numberValue), file: file, line: line)

        default:
            XCTFail("expected UInt32 to be convertible to .number")
        }
    }
}



// MARK: - UInt64
final class UInt64ValueConvertibleTests: XCTestCase {
    func test_uint64_to_value() {
        validate_uint64_convertible(0)
        validate_uint64_convertible(1)
        validate_uint64_convertible(5)
        validate_uint64_convertible(127)
    }

    private func validate_uint64_convertible(_ uint64: UInt64, file: StaticString = #file, line: UInt = #line) {
        let value = uint64.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(uint64, UInt64(numberValue), file: file, line: line)

        default:
            XCTFail("expected UInt64 to be convertible to .number")
        }
    }
}



