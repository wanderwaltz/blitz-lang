import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/shared/equal.rb
final class IntegerEqualityTests: XCTestCase {
    func test__integer_equality() {
        expect_source("1 == 1", yields: true)
        expect_source("9 == 5", yields: false)
        expect_source("9 == 9.0", yields: true)
        expect_source("9 == 9.1", yields: false)

        expect_source("9 == nil", yields: false)
        expect_source("9 == true", yields: false)
        expect_source("9 == false", yields: false)
        expect_source("9 == \"9\"", yields: false)
    }
}
