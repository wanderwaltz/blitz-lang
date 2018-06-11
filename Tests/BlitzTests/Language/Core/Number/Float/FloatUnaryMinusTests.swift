import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/uminus_spec.rb
final class FloatUnaryMinusTests: XCTestCase {
    func test__float_unary_minus_values() {
        expect_source("-2.221", yields: -2.221, tolerance: FLOAT_TOLERANCE)
        expect_source("--2.01", yields: 2.01, tolerance: FLOAT_TOLERANCE)
        expect_source("-2455999221.5512", yields: -2455999221.5512, tolerance: FLOAT_TOLERANCE)
    }
}
