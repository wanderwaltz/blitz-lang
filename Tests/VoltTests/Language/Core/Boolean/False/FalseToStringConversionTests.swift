import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/false/to_s_spec.rb
final class FalseToStringConversioTests: XCTestCase {
    func test__false_to_string_conversion_using_string_concatenation() {
        expect_source("\"\" + false", yields: "false")
    }
}
