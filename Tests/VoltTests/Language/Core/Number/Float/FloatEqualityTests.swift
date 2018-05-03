import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/eql_spec.rb
final class FloatEqualityTests: XCTestCase {
    func test__float_equality() {
        expect_source("0.0 == 0.0", yields: true)
        expect_source("1.0 == 1.1", yields: false)

        expect_source("1.0 == nil", yields: false)
        expect_source("1.0 == true", yields: false)
        expect_source("1.0 == false", yields: false)
        expect_source("1.0 == \"9\"", yields: false)
    }
}
