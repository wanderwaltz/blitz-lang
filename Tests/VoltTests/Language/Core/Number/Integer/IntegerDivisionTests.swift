import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/divide_spec.rb
final class IntegerDivisionTests: XCTestCase {
    func test__integer_division__values() {
        // Number is always a floating point value, so division is performed as
        // floating-point division even if both operands are integer literals
        expect_source("2 / 2", yields: 1)
        expect_source("3 / 2", yields: 1.5)
        expect_source("-1 / 10", yields: -0.1)
    }

    func test__integer_division__type_errors() {
        expect_source("13 / nil", yields: .typeError)
        expect_source("13 / true", yields: .typeError)
        expect_source("13 / false", yields: .typeError)
        expect_source("13 / \"10\"", yields: .typeError)
    }
}
