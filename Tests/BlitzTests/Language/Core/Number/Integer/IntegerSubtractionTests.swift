import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/minus_spec.rb
final class IntegerSubtractionTests: XCTestCase {
    func test__integer_subtraction__values() {
        expect_source("5 - 10", yields: -5)
        expect_source("9237212 - 5280", yields: 9231932)
        expect_source("781 - 0.5", yields: 780.5)
    }

    func test__integer_subtraction__type_errors() {
        expect_source("13 - nil", yields: .typeError)
        expect_source("13 - true", yields: .typeError)
        expect_source("13 - false", yields: .typeError)
        expect_source("13 - \"10\"", yields: .typeError)
    }
}
