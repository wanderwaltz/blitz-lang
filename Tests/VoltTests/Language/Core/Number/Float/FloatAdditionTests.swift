import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/plus_spec.rb
final class FloatAdditionTests: XCTestCase {
    func test__float_addition__values() {
        expect_source("491.213 + 2", yields: 493.213, tolerance: FLOAT_TOLERANCE)
        expect_source("1001.99 + 5.219", yields: 1007.209, tolerance: FLOAT_TOLERANCE)
        expect_source("1001.99 + \"10\"", yields: "1001.9910")
    }

    func test__float_addition__type_errors() {
        expect_source("491.213 + nil", yields: .typeError)
        expect_source("491.213 + true", yields: .typeError)
        expect_source("491.213 + false", yields: .typeError)
    }
}
