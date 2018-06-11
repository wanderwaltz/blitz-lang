import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/true/to_s_spec.rb
final class TrueToStringConversioTests: XCTestCase {
    func test__true_to_string_conversion_using_string_concatenation() {
        expect_source("\"\" + true", yields: "true")
    }
}
