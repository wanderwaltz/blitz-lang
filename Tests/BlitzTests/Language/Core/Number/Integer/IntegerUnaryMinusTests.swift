import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/uminus_spec.rb
final class IntegerUnaryMinusTests: XCTestCase {
    func test__integer_unary_minus_values() {
        expect_source("-2", yields: -2)
        expect_source("-268435455", yields: -268435455)
        expect_source("--5", yields: 5)
        expect_source("-8", yields: -8)
        expect_source("-0", yields: 0)
    }
}
