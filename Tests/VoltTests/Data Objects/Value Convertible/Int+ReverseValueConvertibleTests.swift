// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Int8
final class Int8ReverseValueConvertibleTests: XCTestCase {
    func test_int8_from_value() {
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
        guard let reverse_any = Int8.fromVoltValue(value) else {
            XCTFail("conversion failed for \(int8)", file: file, line: line)
            return
        }

        guard let cast = typecast<Int8>.any(reverse_any) else {
            XCTFail("failed casting \(int8)", file: file, line: line)
            return
        }

        XCTAssertEqual(int8, cast, file: file, line: line)
    }
}



// MARK: - Int16
final class Int16ReverseValueConvertibleTests: XCTestCase {
    func test_int16_from_value() {
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
        guard let reverse_any = Int16.fromVoltValue(value) else {
            XCTFail("conversion failed for \(int16)", file: file, line: line)
            return
        }

        guard let cast = typecast<Int16>.any(reverse_any) else {
            XCTFail("failed casting \(int16)", file: file, line: line)
            return
        }

        XCTAssertEqual(int16, cast, file: file, line: line)
    }
}



// MARK: - Int32
final class Int32ReverseValueConvertibleTests: XCTestCase {
    func test_int32_from_value() {
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
        guard let reverse_any = Int32.fromVoltValue(value) else {
            XCTFail("conversion failed for \(int32)", file: file, line: line)
            return
        }

        guard let cast = typecast<Int32>.any(reverse_any) else {
            XCTFail("failed casting \(int32)", file: file, line: line)
            return
        }

        XCTAssertEqual(int32, cast, file: file, line: line)
    }
}



// MARK: - Int64
final class Int64ReverseValueConvertibleTests: XCTestCase {
    func test_int64_from_value() {
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
        guard let reverse_any = Int64.fromVoltValue(value) else {
            XCTFail("conversion failed for \(int64)", file: file, line: line)
            return
        }

        guard let cast = typecast<Int64>.any(reverse_any) else {
            XCTFail("failed casting \(int64)", file: file, line: line)
            return
        }

        XCTAssertEqual(int64, cast, file: file, line: line)
    }
}



// MARK: - Int
final class IntReverseValueConvertibleTests: XCTestCase {
    func test_int_from_value() {
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
        guard let reverse_any = Int.fromVoltValue(value) else {
            XCTFail("conversion failed for \(int)", file: file, line: line)
            return
        }

        guard let cast = typecast<Int>.any(reverse_any) else {
            XCTFail("failed casting \(int)", file: file, line: line)
            return
        }

        XCTAssertEqual(int, cast, file: file, line: line)
    }
}



// MARK: - UInt
final class UIntReverseValueConvertibleTests: XCTestCase {
    func test_uint_from_value() {
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
        guard let reverse_any = UInt.fromVoltValue(value) else {
            XCTFail("conversion failed for \(uint)", file: file, line: line)
            return
        }

        guard let cast = typecast<UInt>.any(reverse_any) else {
            XCTFail("failed casting \(uint)", file: file, line: line)
            return
        }

        XCTAssertEqual(uint, cast, file: file, line: line)
    }
}



// MARK: - UInt8
final class UInt8ReverseValueConvertibleTests: XCTestCase {
    func test_uint8_from_value() {
        validate_uint8_reverse_convertible(0)
        validate_uint8_reverse_convertible(1)
        validate_uint8_reverse_convertible(2)
        validate_uint8_reverse_convertible(3)
        validate_uint8_reverse_convertible(42)
        validate_uint8_reverse_convertible(100)
    }

    private func validate_uint8_reverse_convertible(_ uint8: UInt8, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(uint8))
        guard let reverse_any = UInt8.fromVoltValue(value) else {
            XCTFail("conversion failed for \(uint8)", file: file, line: line)
            return
        }

        guard let cast = typecast<UInt8>.any(reverse_any) else {
            XCTFail("failed casting \(uint8)", file: file, line: line)
            return
        }

        XCTAssertEqual(uint8, cast, file: file, line: line)
    }
}



// MARK: - UInt16
final class UInt16ReverseValueConvertibleTests: XCTestCase {
    func test_uint16_from_value() {
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
        guard let reverse_any = UInt16.fromVoltValue(value) else {
            XCTFail("conversion failed for \(uint16)", file: file, line: line)
            return
        }

        guard let cast = typecast<UInt16>.any(reverse_any) else {
            XCTFail("failed casting \(uint16)", file: file, line: line)
            return
        }

        XCTAssertEqual(uint16, cast, file: file, line: line)
    }
}



// MARK: - UInt32
final class UInt32ReverseValueConvertibleTests: XCTestCase {
    func test_uint32_from_value() {
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
        guard let reverse_any = UInt32.fromVoltValue(value) else {
            XCTFail("conversion failed for \(uint32)", file: file, line: line)
            return
        }

        guard let cast = typecast<UInt32>.any(reverse_any) else {
            XCTFail("failed casting \(uint32)", file: file, line: line)
            return
        }

        XCTAssertEqual(uint32, cast, file: file, line: line)
    }
}



// MARK: - UInt64
final class UInt64ReverseValueConvertibleTests: XCTestCase {
    func test_uint64_from_value() {
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
        guard let reverse_any = UInt64.fromVoltValue(value) else {
            XCTFail("conversion failed for \(uint64)", file: file, line: line)
            return
        }

        guard let cast = typecast<UInt64>.any(reverse_any) else {
            XCTFail("failed casting \(uint64)", file: file, line: line)
            return
        }

        XCTAssertEqual(uint64, cast, file: file, line: line)
    }
}



