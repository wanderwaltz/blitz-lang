import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/gt_spec.rb
final class FloatGreaterThanTests: XCTestCase {
    func test__float_greater_than__values() {
        expect_source("1.5 > 1", yields: true)
        expect_source("2.5 > 3", yields: false)
    }

    func test__float_greater_than__type_errors() {
        expect_source("5.0 > \"4\"", yields: .typeError)
        expect_source("5.0 > nil", yields: .typeError)
        expect_source("5.0 > true", yields: .typeError)
        expect_source("5.0 > false", yields: .typeError)
    }
}
