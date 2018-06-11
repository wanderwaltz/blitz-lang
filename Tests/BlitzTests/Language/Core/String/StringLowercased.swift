import XCTest

/// This test case assumes the default String delegate is set up
final class StringLowecasedTests: XCTestCase {
    func test__string_lowercased_values() {
        expect_source("\"Hello, World!\".lowercased()", yields: "hello, world!")
        expect_source("\"КириЛлИЦа\".lowercased()", yields: "кириллица")
        expect_source("\"🤣\".lowercased()", yields: "🤣")
        expect_source("\"\".lowercased()", yields: "")
    }
}
