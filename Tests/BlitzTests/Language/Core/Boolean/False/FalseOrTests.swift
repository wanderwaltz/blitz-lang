import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/false/or_spec.rb
final class FalseOrTests: XCTestCase {
    func test__or_value() {
        expect_source("false or true", yields: true)
        expect_source("false or 1", yields: true)
        expect_source("false or -1", yields: true)
        expect_source("false or \"qwerty\"", yields: true)

        expect_source("false or false", yields: false)
        expect_source("false or nil", yields: false)
        expect_source("false or 0", yields: false)
        expect_source("false or \"\"", yields: false)
    }

    func test__it_evaluates_right_side_of_or() {
        expect_source("false or x", yields: .unknownIdentifier)
    }
}
