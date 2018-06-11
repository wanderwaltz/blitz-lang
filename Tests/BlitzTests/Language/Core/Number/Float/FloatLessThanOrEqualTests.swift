import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/lte_spec.rb
final class FloatLessThanOrEqualTests: XCTestCase {
    func test__float_less_than_or_equal__values() {
        expect_source("2.0 <= 3.14159", yields: true)
        expect_source("-2.7183 <= -24", yields: false)
        expect_source("0.0 <= 0.0", yields: true)
    }

    func test__float_less_than_or_equal__type_errors() {
        expect_source("5.0 <= \"4\"", yields: .typeError)
        expect_source("5.0 <= nil", yields: .typeError)
        expect_source("5.0 <= true", yields: .typeError)
        expect_source("5.0 <= false", yields: .typeError)
    }
}
