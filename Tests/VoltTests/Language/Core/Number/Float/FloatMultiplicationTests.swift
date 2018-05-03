import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/multiply_spec.rb
final class FloatMultiplicationTests: XCTestCase {
    func test__float_multiplication__values() {
        expect_source("4923.98221 * 2", yields: 9847.96442, tolerance: FLOAT_TOLERANCE)
        expect_source("6712.5 * 0.25", yields: 1678.125, tolerance: FLOAT_TOLERANCE)
    }

    func test__float_multiplication__type_errors() {
        expect_source("491.213 * nil", yields: .typeError)
        expect_source("1001.99 * \"10\"", yields: .typeError)
        expect_source("491.213 * true", yields: .typeError)
        expect_source("491.213 * false", yields: .typeError)
    }
}
