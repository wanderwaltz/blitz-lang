import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/shared/next.rb
final class IntegerIncrementTests: XCTestCase {
    func test__integer_increment_using_plus() {
        expect_source("2 + 1", yields: 3)
        expect_source("-2 + 1", yields: -1)
    }
}
