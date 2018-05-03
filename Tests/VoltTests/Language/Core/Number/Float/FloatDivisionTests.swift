import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/divide_spec.rb
final class FloatDivisionTests: XCTestCase {
    func test__float_division__values() {
        expect_source("5.75 / -2", yields: -2.875, tolerance: FLOAT_TOLERANCE)
        expect_source("451.0 / 9.3", yields: 48.494623655914, tolerance: FLOAT_TOLERANCE)
    }

    func test__float_division__type_errors() {
        expect_source("491.213 / nil", yields: .typeError)
        expect_source("1001.99 / \"10\"", yields: .typeError)
        expect_source("491.213 / true", yields: .typeError)
        expect_source("491.213 / false", yields: .typeError)
    }
}
