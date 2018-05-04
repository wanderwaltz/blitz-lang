import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/true/or_spec.rb
final class TrueOrTests: XCTestCase {
    func test__or_value() {
        expect_source("true or true", yields: true)
        expect_source("true or 1", yields: true)
        expect_source("true or -1", yields: true)
        expect_source("true or \"qwerty\"", yields: true)
        expect_source("true or false", yields: true)
        expect_source("true or nil", yields: true)
        expect_source("true or 0", yields: true)
        expect_source("true or \"\"", yields: true)
    }

    func test__it_does_not_evaluate_right_side_of_or() {
        // if the right side was evaluated, an .unknownIdentifier error would be yielded
        expect_source("true or x", yields: true)
    }
}
