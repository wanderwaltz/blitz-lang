import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/multiply_spec.rb
final class IntegerMultiplicationTests: XCTestCase {
    func test__integer_multiplication__values() {
        expect_source("4923 * 2", yields: 9846)
        expect_source("1342177 * 800", yields: 1073741600)
        expect_source("65536 * 65536", yields: 4294967296)
        expect_source("6712 * 0.25", yields: 1678.0)
    }

    func test__integer_multiplication__type_errors() {
        expect_source("13 * nil", yields: .typeError)
        expect_source("13 * true", yields: .typeError)
        expect_source("13 * false", yields: .typeError)
        expect_source("13 * \"10\"", yields: .typeError)
    }
}
