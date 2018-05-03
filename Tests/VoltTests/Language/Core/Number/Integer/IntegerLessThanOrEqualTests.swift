import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/lte_spec.rb
final class IntegerLessThanOrEqualTests: XCTestCase {
    func test__integer_less_than_or_equal__values() {
        expect_source("2 <= 13", yields: true)
        expect_source("-600 <= -500", yields: true)

        expect_source("5 <= 1", yields: false)
        expect_source("5 <= 5", yields: true)
        expect_source("-2 <= -2", yields: true)

        expect_source("5 <= 4.999", yields: false)
    }

    func test__integer_less_than_or_equal__type_errors() {
        expect_source("5 <= \"4\"", yields: .typeError)
        expect_source("5 <= nil", yields: .typeError)
        expect_source("5 <= true", yields: .typeError)
        expect_source("5 <= false", yields: .typeError)
    }
}
