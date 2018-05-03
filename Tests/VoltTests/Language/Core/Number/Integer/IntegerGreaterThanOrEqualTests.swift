import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/gte_spec.rb
final class IntegerGreaterThanOrEqualTests: XCTestCase {
    func test__integer_greater_than_or_equal__values() {
        expect_source("13 >= 2", yields: true)
        expect_source("-500 >= -600", yields: true)

        expect_source("1 >= 5", yields: false)
        expect_source("2 >= 2", yields: true)
        expect_source("-5 >= -5", yields: true)

        expect_source("5 >= 4.999", yields: true)
    }

    func test__integer_greater_than_or_equal__type_errors() {
        expect_source("5 >= \"4\"", yields: .typeError)
        expect_source("5 >= nil", yields: .typeError)
    }
}
