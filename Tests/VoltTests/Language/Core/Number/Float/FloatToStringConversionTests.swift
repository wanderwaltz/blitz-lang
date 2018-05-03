import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/to_s_spec.rb
final class FloatToStringConversionTests: XCTestCase {
    func test__float_to_string_conversion_using_string_concatenation() {
        expect_source("\"\" + 0.0", yields: "0")
        expect_source("\"\" + -3.14", yields: "-3.14")
        expect_source("\"\" + 0.0001", yields: "0.0001")
        expect_source("\"\" + 10000000000000.1", yields: "10000000000000.1")
    }
}
