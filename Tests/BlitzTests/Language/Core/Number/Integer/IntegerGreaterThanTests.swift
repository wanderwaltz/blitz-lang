import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/gt_spec.rb
final class IntegerGreaterThanTests: XCTestCase {
    func test__integer_greater_than__values() {
        expect_source("13 > 2", yields: true)
        expect_source("-500 > -600", yields: true)

        expect_source("1 > 5", yields: false)
        expect_source("5 > 5", yields: false)

        expect_source("5 > 4.999", yields: true)
    }

    func test__integer_greater_than__type_errors() {
        expect_source("5 > \"4\"", yields: .typeError)
        expect_source("5 > nil", yields: .typeError)
        expect_source("5 > true", yields: .typeError)
        expect_source("5 > false", yields: .typeError)
    }
}
