import XCTest

/// This test case assumes the default String delegate is set up
final class StringUppercasedTests: XCTestCase {
    func test__string_uppercased_values() {
        expect_source("\"Hello, World!\".uppercased()", yields: "HELLO, WORLD!")
        expect_source("\"Кириллица\".uppercased()", yields: "КИРИЛЛИЦА")
        expect_source("\"🤣\".uppercased()", yields: "🤣")
        expect_source("\"\".uppercased()", yields: "")
    }
}
