// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Int8
final class Int8ReverseValueConvertibleTests: XCTestCase {
    func test_int8_to_value() {
        validate_int8_reverse_convertible(0)
        validate_int8_reverse_convertible(1)
        validate_int8_reverse_convertible(2)
        validate_int8_reverse_convertible(3)
        validate_int8_reverse_convertible(42)
        validate_int8_reverse_convertible(100)
        validate_int8_reverse_convertible(-1)
        validate_int8_reverse_convertible(-2)
        validate_int8_reverse_convertible(-3)
        validate_int8_reverse_convertible(-42)
        validate_int8_reverse_convertible(-100)
    }

    private func validate_int8_reverse_convertible(_ int8: Int8, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(int8))
        let reverse_any = Int8.fromVoltValue(value)
        XCTAssertEqual(int8, typecast<Int8>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - Int16
final class Int16ReverseValueConvertibleTests: XCTestCase {
    func test_int16_to_value() {
        validate_int16_reverse_convertible(0)
        validate_int16_reverse_convertible(1)
        validate_int16_reverse_convertible(2)
        validate_int16_reverse_convertible(3)
        validate_int16_reverse_convertible(42)
        validate_int16_reverse_convertible(100)
        validate_int16_reverse_convertible(1024)
        validate_int16_reverse_convertible(2000)
        validate_int16_reverse_convertible(32000)
        validate_int16_reverse_convertible(-1)
        validate_int16_reverse_convertible(-2)
        validate_int16_reverse_convertible(-3)
        validate_int16_reverse_convertible(-42)
        validate_int16_reverse_convertible(-100)
        validate_int16_reverse_convertible(-1024)
        validate_int16_reverse_convertible(-2000)
        validate_int16_reverse_convertible(-32000)
    }

    private func validate_int16_reverse_convertible(_ int16: Int16, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(int16))
        let reverse_any = Int16.fromVoltValue(value)
        XCTAssertEqual(int16, typecast<Int16>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - Int32
final class Int32ReverseValueConvertibleTests: XCTestCase {
    func test_int32_to_value() {
        validate_int32_reverse_convertible(0)
        validate_int32_reverse_convertible(1)
        validate_int32_reverse_convertible(2)
        validate_int32_reverse_convertible(3)
        validate_int32_reverse_convertible(42)
        validate_int32_reverse_convertible(100)
        validate_int32_reverse_convertible(1024)
        validate_int32_reverse_convertible(2000)
        validate_int32_reverse_convertible(32000)
        validate_int32_reverse_convertible(1000000)
        validate_int32_reverse_convertible(2000000000)
        validate_int32_reverse_convertible(-1)
        validate_int32_reverse_convertible(-2)
        validate_int32_reverse_convertible(-3)
        validate_int32_reverse_convertible(-42)
        validate_int32_reverse_convertible(-100)
        validate_int32_reverse_convertible(-1024)
        validate_int32_reverse_convertible(-2000)
        validate_int32_reverse_convertible(-32000)
        validate_int32_reverse_convertible(-1000000)
        validate_int32_reverse_convertible(-2000000000)
    }

    private func validate_int32_reverse_convertible(_ int32: Int32, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(int32))
        let reverse_any = Int32.fromVoltValue(value)
        XCTAssertEqual(int32, typecast<Int32>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - Int64
final class Int64ReverseValueConvertibleTests: XCTestCase {
    func test_int64_to_value() {
        validate_int64_reverse_convertible(0)
        validate_int64_reverse_convertible(1)
        validate_int64_reverse_convertible(2)
        validate_int64_reverse_convertible(3)
        validate_int64_reverse_convertible(42)
        validate_int64_reverse_convertible(100)
        validate_int64_reverse_convertible(1024)
        validate_int64_reverse_convertible(2000)
        validate_int64_reverse_convertible(32000)
        validate_int64_reverse_convertible(1000000)
        validate_int64_reverse_convertible(2000000000)
        validate_int64_reverse_convertible(1000000000000)
        validate_int64_reverse_convertible(-1)
        validate_int64_reverse_convertible(-2)
        validate_int64_reverse_convertible(-3)
        validate_int64_reverse_convertible(-42)
        validate_int64_reverse_convertible(-100)
        validate_int64_reverse_convertible(-1024)
        validate_int64_reverse_convertible(-2000)
        validate_int64_reverse_convertible(-32000)
        validate_int64_reverse_convertible(-1000000)
        validate_int64_reverse_convertible(-2000000000)
        validate_int64_reverse_convertible(-1000000000000)
    }

    private func validate_int64_reverse_convertible(_ int64: Int64, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(int64))
        let reverse_any = Int64.fromVoltValue(value)
        XCTAssertEqual(int64, typecast<Int64>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - Int
final class IntReverseValueConvertibleTests: XCTestCase {
    func test_int_to_value() {
        validate_int_reverse_convertible(0)
        validate_int_reverse_convertible(1)
        validate_int_reverse_convertible(2)
        validate_int_reverse_convertible(3)
        validate_int_reverse_convertible(42)
        validate_int_reverse_convertible(100)
        validate_int_reverse_convertible(1024)
        validate_int_reverse_convertible(2000)
        validate_int_reverse_convertible(32000)
        validate_int_reverse_convertible(1000000)
        validate_int_reverse_convertible(2000000000)
        validate_int_reverse_convertible(-1)
        validate_int_reverse_convertible(-2)
        validate_int_reverse_convertible(-3)
        validate_int_reverse_convertible(-42)
        validate_int_reverse_convertible(-100)
        validate_int_reverse_convertible(-1024)
        validate_int_reverse_convertible(-2000)
        validate_int_reverse_convertible(-32000)
        validate_int_reverse_convertible(-1000000)
        validate_int_reverse_convertible(-2000000000)
    }

    private func validate_int_reverse_convertible(_ int: Int, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(int))
        let reverse_any = Int.fromVoltValue(value)
        XCTAssertEqual(int, typecast<Int>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - UInt
final class UIntReverseValueConvertibleTests: XCTestCase {
    func test_uint_to_value() {
        validate_uint_reverse_convertible(0)
        validate_uint_reverse_convertible(1)
        validate_uint_reverse_convertible(2)
        validate_uint_reverse_convertible(3)
        validate_uint_reverse_convertible(42)
        validate_uint_reverse_convertible(100)
        validate_uint_reverse_convertible(1024)
        validate_uint_reverse_convertible(2000)
        validate_uint_reverse_convertible(32000)
        validate_uint_reverse_convertible(1000000)
        validate_uint_reverse_convertible(2000000000)
    }

    private func validate_uint_reverse_convertible(_ uint: UInt, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint))
        let reverse_any = UInt.fromVoltValue(value)
        XCTAssertEqual(uint, typecast<UInt>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - UInt8
final class UInt8ReverseValueConvertibleTests: XCTestCase {
    func test_uint8_to_value() {
        validate_uint8_reverse_convertible(0)
        validate_uint8_reverse_convertible(1)
        validate_uint8_reverse_convertible(2)
        validate_uint8_reverse_convertible(3)
        validate_uint8_reverse_convertible(42)
        validate_uint8_reverse_convertible(100)
    }

    private func validate_uint8_reverse_convertible(_ uint8: UInt8, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint8))
        let reverse_any = UInt8.fromVoltValue(value)
        XCTAssertEqual(uint8, typecast<UInt8>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - UInt16
final class UInt16ReverseValueConvertibleTests: XCTestCase {
    func test_uint16_to_value() {
        validate_uint16_reverse_convertible(0)
        validate_uint16_reverse_convertible(1)
        validate_uint16_reverse_convertible(2)
        validate_uint16_reverse_convertible(3)
        validate_uint16_reverse_convertible(42)
        validate_uint16_reverse_convertible(100)
        validate_uint16_reverse_convertible(1024)
        validate_uint16_reverse_convertible(2000)
        validate_uint16_reverse_convertible(32000)
    }

    private func validate_uint16_reverse_convertible(_ uint16: UInt16, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint16))
        let reverse_any = UInt16.fromVoltValue(value)
        XCTAssertEqual(uint16, typecast<UInt16>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - UInt32
final class UInt32ReverseValueConvertibleTests: XCTestCase {
    func test_uint32_to_value() {
        validate_uint32_reverse_convertible(0)
        validate_uint32_reverse_convertible(1)
        validate_uint32_reverse_convertible(2)
        validate_uint32_reverse_convertible(3)
        validate_uint32_reverse_convertible(42)
        validate_uint32_reverse_convertible(100)
        validate_uint32_reverse_convertible(1024)
        validate_uint32_reverse_convertible(2000)
        validate_uint32_reverse_convertible(32000)
        validate_uint32_reverse_convertible(1000000)
        validate_uint32_reverse_convertible(2000000000)
    }

    private func validate_uint32_reverse_convertible(_ uint32: UInt32, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint32))
        let reverse_any = UInt32.fromVoltValue(value)
        XCTAssertEqual(uint32, typecast<UInt32>.any(reverse_any), file: file, line: line)
    }
}



// MARK: - UInt64
final class UInt64ReverseValueConvertibleTests: XCTestCase {
    func test_uint64_to_value() {
        validate_uint64_reverse_convertible(0)
        validate_uint64_reverse_convertible(1)
        validate_uint64_reverse_convertible(2)
        validate_uint64_reverse_convertible(3)
        validate_uint64_reverse_convertible(42)
        validate_uint64_reverse_convertible(100)
        validate_uint64_reverse_convertible(1024)
        validate_uint64_reverse_convertible(2000)
        validate_uint64_reverse_convertible(32000)
        validate_uint64_reverse_convertible(1000000)
        validate_uint64_reverse_convertible(2000000000)
        validate_uint64_reverse_convertible(1000000000000)
    }

    private func validate_uint64_reverse_convertible(_ uint64: UInt64, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint64))
        let reverse_any = UInt64.fromVoltValue(value)
        XCTAssertEqual(uint64, typecast<UInt64>.any(reverse_any), file: file, line: line)
    }
}
