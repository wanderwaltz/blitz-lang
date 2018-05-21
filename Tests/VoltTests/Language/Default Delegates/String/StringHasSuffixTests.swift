import XCTest

/// This test case assumes the default String delegate is set up
final class StringHasSuffixTests: XCTestCase {
    func test__string_hasSuffix_values() {
        expect_source("\"Hello, World!\".hasSuffix(\"World!\")", yields: true)
        expect_source("\"Кириллица\".hasSuffix(\"ица\")", yields: true)

        expect_source("\"🤣\".hasSuffix(\"Hello\")", yields: false)
        expect_source("\"\".hasSuffix(\"any\")", yields: false)
    }

    func test__string_hasSuffix_is_case_sensitive() {
        expect_source("\"Hello, World!\".hasSuffix(\"world!\")", yields: false)
    }
}
