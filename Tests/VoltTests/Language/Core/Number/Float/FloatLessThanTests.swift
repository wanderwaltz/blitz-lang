import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/float/lt_spec.rb
final class FloatLessThanTests: XCTestCase {
    func test__float_less_than__values() {
        expect_source("71.3 < 91.8", yields: true)
        expect_source("192.6 < -500", yields: false)
    }

    func test__float_less_than__type_errors() {
        expect_source("5.0 < \"4\"", yields: .typeError)
        expect_source("5.0 < nil", yields: .typeError)
        expect_source("5.0 < true", yields: .typeError)
        expect_source("5.0 < false", yields: .typeError)
    }
}
