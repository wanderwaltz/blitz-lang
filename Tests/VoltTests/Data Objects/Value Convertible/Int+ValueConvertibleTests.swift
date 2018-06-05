// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Int8
final class Int8ValueConvertibleTests: XCTestCase {
    func test_int8_to_value() {
        validate_int8_convertible(0)
        validate_int8_convertible(1)
        validate_int8_convertible(2)
        validate_int8_convertible(3)
        validate_int8_convertible(42)
        validate_int8_convertible(100)
        validate_int8_convertible(-1)
        validate_int8_convertible(-2)
        validate_int8_convertible(-3)
        validate_int8_convertible(-42)
        validate_int8_convertible(-100)
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



// MARK: - Int16
final class Int16ValueConvertibleTests: XCTestCase {
    func test_int16_to_value() {
        validate_int16_convertible(0)
        validate_int16_convertible(1)
        validate_int16_convertible(2)
        validate_int16_convertible(3)
        validate_int16_convertible(42)
        validate_int16_convertible(100)
        validate_int16_convertible(1024)
        validate_int16_convertible(2000)
        validate_int16_convertible(32000)
        validate_int16_convertible(-1)
        validate_int16_convertible(-2)
        validate_int16_convertible(-3)
        validate_int16_convertible(-42)
        validate_int16_convertible(-100)
        validate_int16_convertible(-1024)
        validate_int16_convertible(-2000)
        validate_int16_convertible(-32000)
    }

    private func validate_int16_convertible(_ int16: Int16, file: StaticString = #file, line: UInt = #line) {
        let value = int16.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(int16, Int16(numberValue), file: file, line: line)

        default:
            XCTFail("expected Int16 to be convertible to .number")
        }
    }
}



// MARK: - Int32
final class Int32ValueConvertibleTests: XCTestCase {
    func test_int32_to_value() {
        validate_int32_convertible(0)
        validate_int32_convertible(1)
        validate_int32_convertible(2)
        validate_int32_convertible(3)
        validate_int32_convertible(42)
        validate_int32_convertible(100)
        validate_int32_convertible(1024)
        validate_int32_convertible(2000)
        validate_int32_convertible(32000)
        validate_int32_convertible(1000000)
        validate_int32_convertible(2000000000)
        validate_int32_convertible(-1)
        validate_int32_convertible(-2)
        validate_int32_convertible(-3)
        validate_int32_convertible(-42)
        validate_int32_convertible(-100)
        validate_int32_convertible(-1024)
        validate_int32_convertible(-2000)
        validate_int32_convertible(-32000)
        validate_int32_convertible(-1000000)
        validate_int32_convertible(-2000000000)
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
        validate_int64_convertible(2)
        validate_int64_convertible(3)
        validate_int64_convertible(42)
        validate_int64_convertible(100)
        validate_int64_convertible(1024)
        validate_int64_convertible(2000)
        validate_int64_convertible(32000)
        validate_int64_convertible(1000000)
        validate_int64_convertible(2000000000)
        validate_int64_convertible(1000000000000)
        validate_int64_convertible(-1)
        validate_int64_convertible(-2)
        validate_int64_convertible(-3)
        validate_int64_convertible(-42)
        validate_int64_convertible(-100)
        validate_int64_convertible(-1024)
        validate_int64_convertible(-2000)
        validate_int64_convertible(-32000)
        validate_int64_convertible(-1000000)
        validate_int64_convertible(-2000000000)
        validate_int64_convertible(-1000000000000)
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



// MARK: - Int
final class IntValueConvertibleTests: XCTestCase {
    func test_int_to_value() {
        validate_int_convertible(0)
        validate_int_convertible(1)
        validate_int_convertible(2)
        validate_int_convertible(3)
        validate_int_convertible(42)
        validate_int_convertible(100)
        validate_int_convertible(1024)
        validate_int_convertible(2000)
        validate_int_convertible(32000)
        validate_int_convertible(1000000)
        validate_int_convertible(2000000000)
        validate_int_convertible(-1)
        validate_int_convertible(-2)
        validate_int_convertible(-3)
        validate_int_convertible(-42)
        validate_int_convertible(-100)
        validate_int_convertible(-1024)
        validate_int_convertible(-2000)
        validate_int_convertible(-32000)
        validate_int_convertible(-1000000)
        validate_int_convertible(-2000000000)
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



// MARK: - UInt
final class UIntValueConvertibleTests: XCTestCase {
    func test_uint_to_value() {
        validate_uint_convertible(0)
        validate_uint_convertible(1)
        validate_uint_convertible(2)
        validate_uint_convertible(3)
        validate_uint_convertible(42)
        validate_uint_convertible(100)
        validate_uint_convertible(1024)
        validate_uint_convertible(2000)
        validate_uint_convertible(32000)
        validate_uint_convertible(1000000)
        validate_uint_convertible(2000000000)
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
        validate_uint8_convertible(2)
        validate_uint8_convertible(3)
        validate_uint8_convertible(42)
        validate_uint8_convertible(100)
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



// MARK: - UInt16
final class UInt16ValueConvertibleTests: XCTestCase {
    func test_uint16_to_value() {
        validate_uint16_convertible(0)
        validate_uint16_convertible(1)
        validate_uint16_convertible(2)
        validate_uint16_convertible(3)
        validate_uint16_convertible(42)
        validate_uint16_convertible(100)
        validate_uint16_convertible(1024)
        validate_uint16_convertible(2000)
        validate_uint16_convertible(32000)
    }

    private func validate_uint16_convertible(_ uint16: UInt16, file: StaticString = #file, line: UInt = #line) {
        let value = uint16.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(uint16, UInt16(numberValue), file: file, line: line)

        default:
            XCTFail("expected UInt16 to be convertible to .number")
        }
    }
}



// MARK: - UInt32
final class UInt32ValueConvertibleTests: XCTestCase {
    func test_uint32_to_value() {
        validate_uint32_convertible(0)
        validate_uint32_convertible(1)
        validate_uint32_convertible(2)
        validate_uint32_convertible(3)
        validate_uint32_convertible(42)
        validate_uint32_convertible(100)
        validate_uint32_convertible(1024)
        validate_uint32_convertible(2000)
        validate_uint32_convertible(32000)
        validate_uint32_convertible(1000000)
        validate_uint32_convertible(2000000000)
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
        validate_uint64_convertible(2)
        validate_uint64_convertible(3)
        validate_uint64_convertible(42)
        validate_uint64_convertible(100)
        validate_uint64_convertible(1024)
        validate_uint64_convertible(2000)
        validate_uint64_convertible(32000)
        validate_uint64_convertible(1000000)
        validate_uint64_convertible(2000000000)
        validate_uint64_convertible(1000000000000)
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



