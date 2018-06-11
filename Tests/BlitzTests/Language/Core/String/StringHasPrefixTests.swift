import XCTest

/// This test case assumes the default String delegate is set up
final class StringHasPrefixTests: XCTestCase {
    func test__string_hasPrefix_values() {
        expect_source("\"Hello, World!\".hasPrefix(\"Hello\")", yields: true)
        expect_source("\"Кириллица\".hasPrefix(\"Кирилл\")", yields: true)

        expect_source("\"🤣\".hasPrefix(\"Hello\")", yields: false)
        expect_source("\"\".hasPrefix(\"any\")", yields: false)
    }

    func test__string_hasPrefix_is_case_sensitive() {
        expect_source("\"Hello, World!\".hasPrefix(\"hello\")", yields: false)
    }
}
