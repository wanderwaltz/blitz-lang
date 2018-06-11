import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/gte_spec.rb
final class FloatGreaterThanOrEqualTests: XCTestCase {
    func test__float_greater_than_or_equal__values() {
        expect_source("5.2 >= 5.2", yields: true)
        expect_source("9.71 >= 1", yields: true)
    }

    func test__float_greater_than_or_equal__type_errors() {
        expect_source("5.0 >= \"4\"", yields: .typeError)
        expect_source("5.0 >= nil", yields: .typeError)
        expect_source("5.0 >= true", yields: .typeError)
        expect_source("5.0 >= false", yields: .typeError)
    }
}
