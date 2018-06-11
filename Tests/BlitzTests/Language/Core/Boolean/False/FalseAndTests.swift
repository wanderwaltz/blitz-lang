import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/false/and_spec.rb
final class FalseAndTests: XCTestCase {
    func test__and_value() {
        expect_source("false and true", yields: false)
        expect_source("false and 1", yields: false)
        expect_source("false and -1", yields: false)
        expect_source("false and \"qwerty\"", yields: false)
        expect_source("false and false", yields: false)
        expect_source("false and nil", yields: false)
        expect_source("false and 0", yields: false)
        expect_source("false and \"\"", yields: false)
    }

    func test__it_does_not_evaluate_right_side_of_and() {
        // if the right side was evaluated, an .unknownIdentifier error would be yielded
        expect_source("false and x", yields: false)
    }
}
