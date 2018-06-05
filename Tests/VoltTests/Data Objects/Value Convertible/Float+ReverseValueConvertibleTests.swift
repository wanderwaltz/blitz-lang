// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Float
final class FloatReverseValueConvertibleTests: XCTestCase {
    func test_float_from_value() {
        validate_float_reverse_convertible(0.0)
        validate_float_reverse_convertible(0.1)
        validate_float_reverse_convertible(1.0)
        validate_float_reverse_convertible(-1.0)
        validate_float_reverse_convertible(10000)
        validate_float_reverse_convertible(1e3)
        validate_float_reverse_convertible(-500)
        validate_float_reverse_convertible(100500)
        validate_float_reverse_convertible(100.500)
    }

    private func validate_float_reverse_convertible(_ float: Float, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(float))

        guard let reverse_any = Float.fromVoltValue(value) else {
            XCTFail("failed generating Any? for \(float)", file: file, line: line)
            return
        }

        guard let cast = typecast<Float>.any(reverse_any) else {
            XCTFail("failed casting \(float)", file: file, line: line)
            return
        }

        XCTAssertEqual(float, cast, accuracy: Float(FLOAT_TOLERANCE), file: file, line: line)
    }
}



// MARK: - Double
final class DoubleReverseValueConvertibleTests: XCTestCase {
    func test_double_from_value() {
        validate_double_reverse_convertible(0.0)
        validate_double_reverse_convertible(0.1)
        validate_double_reverse_convertible(1.0)
        validate_double_reverse_convertible(-1.0)
        validate_double_reverse_convertible(10000)
        validate_double_reverse_convertible(1e3)
        validate_double_reverse_convertible(-500)
        validate_double_reverse_convertible(100500)
        validate_double_reverse_convertible(100.500)
    }

    private func validate_double_reverse_convertible(_ double: Double, file: StaticString = #file, line: UInt = #line) {
        let value = Value.number(Number(double))

        guard let reverse_any = Double.fromVoltValue(value) else {
            XCTFail("failed generating Any? for \(double)", file: file, line: line)
            return
        }

        guard let cast = typecast<Double>.any(reverse_any) else {
            XCTFail("failed casting \(double)", file: file, line: line)
            return
        }

        XCTAssertEqual(double, cast, accuracy: Double(FLOAT_TOLERANCE), file: file, line: line)
    }
}



