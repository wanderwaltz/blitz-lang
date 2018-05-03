import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/to_s_spec.rb
final class IntegerToStringConversionTests: XCTestCase {
    func test__integer_to_string_conversion_using_string_concatenation() {
        expect_source("\"\" + 12345", yields: "12345")
        expect_source("\"\" + 255", yields: "255")
        expect_source("\"\" + 3", yields: "3")
        expect_source("\"\" + 0", yields: "0")
        expect_source("\"\" + -9002", yields: "-9002")
    }
}
