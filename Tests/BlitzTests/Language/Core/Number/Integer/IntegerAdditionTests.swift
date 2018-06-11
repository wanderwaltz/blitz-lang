import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/core/integer/plus_spec.rb
final class IntegerAdditionTests: XCTestCase {
    func test__integer_addition__values() {
        expect_source("491 + 2", yields: 493)
        expect_source("90210 + 10", yields: 90220)
        expect_source("1001 + 5.219", yields: 1006.219)
        expect_source("13 + \"10\"", yields: "1310")
    }

    func test__integer_addition__type_errors() {
        expect_source("13 + nil", yields: .typeError)
        expect_source("13 + true", yields: .typeError)
        expect_source("13 + false", yields: .typeError)
    }
}
