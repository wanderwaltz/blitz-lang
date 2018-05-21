import XCTest

/// This test case assumes the default String delegate is set up
final class StringCapitalizedTests: XCTestCase {
    func test__string_capitalized_values() {
        expect_source("\"hello, World!\".capitalized()", yields: "Hello, World!")
        expect_source("\"кириЛлИЦа\".capitalized()", yields: "Кириллица")
        expect_source("\"🤣\".capitalized()", yields: "🤣")
        expect_source("\"\".capitalized()", yields: "")

        expect_source(
            "\"there are multiple words in this sentence\".capitalized()",
            yields: "There Are Multiple Words In This Sentence"
        )
    }
}
