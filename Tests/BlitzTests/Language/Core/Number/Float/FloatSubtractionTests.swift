import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/minus_spec.rb
final class FloatSubtractionTests: XCTestCase {
    func test__float_subtraction__values() {
        expect_source("9237212.5280 - 5280", yields: 9231932.528, tolerance: FLOAT_TOLERANCE)
        expect_source("5.5 - 5.5", yields: 0, tolerance: FLOAT_TOLERANCE)
    }

    func test__float_subtraction__type_errors() {
        expect_source("491.213 - nil", yields: .typeError)
        expect_source("1001.99 - \"10\"", yields: .typeError)
        expect_source("491.213 - true", yields: .typeError)
        expect_source("491.213 - false", yields: .typeError)
    }
}
