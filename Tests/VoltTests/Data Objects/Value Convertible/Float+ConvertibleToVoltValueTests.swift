// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Volt

// MARK: - Float
final class FloatConvertibleToVoltValueTests: XCTestCase {
    func test_float_to_value() {
        validate_float_convertible(0.0)
        validate_float_convertible(0.1)
        validate_float_convertible(1.0)
        validate_float_convertible(-1.0)
        validate_float_convertible(10000)
        validate_float_convertible(1e3)
        validate_float_convertible(-500)
        validate_float_convertible(100500)
        validate_float_convertible(100.500)
    }

    private func validate_float_convertible(_ float: Float, file: StaticString = #file, line: UInt = #line) {
        let value = float.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(float, Float(numberValue), accuracy: Float(FLOAT_TOLERANCE), file: file, line: line)

        default:
            XCTFail("expected Float to be convertible to .number")
        }
    }
}



// MARK: - Double
final class DoubleConvertibleToVoltValueTests: XCTestCase {
    func test_double_to_value() {
        validate_double_convertible(0.0)
        validate_double_convertible(0.1)
        validate_double_convertible(1.0)
        validate_double_convertible(-1.0)
        validate_double_convertible(10000)
        validate_double_convertible(1e3)
        validate_double_convertible(-500)
        validate_double_convertible(100500)
        validate_double_convertible(100.500)
    }

    private func validate_double_convertible(_ double: Double, file: StaticString = #file, line: UInt = #line) {
        let value = double.voltValue

        switch value {
        case let .number(numberValue):
            XCTAssertEqual(double, Double(numberValue), accuracy: Double(FLOAT_TOLERANCE), file: file, line: line)

        default:
            XCTFail("expected Double to be convertible to .number")
        }
    }
}



