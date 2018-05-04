import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/true/and_spec.rb
final class TrueAndTests: XCTestCase {
    func test__and_value() {
        expect_source("true and true", yields: true)
        expect_source("true and 1", yields: true)
        expect_source("true and -1", yields: true)
        expect_source("true and \"qwerty\"", yields: true)

        expect_source("true and false", yields: false)
        expect_source("true and nil", yields: false)
        expect_source("true and 0", yields: false)
        expect_source("true and \"\"", yields: false)
    }

    func test__it_evaluates_right_side_of_and() {
        expect_source("true and x", yields: .unknownIdentifier)
    }
}
