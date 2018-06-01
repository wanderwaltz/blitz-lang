import XCTest

/// This test case assumes the default String delegate is set up
final class StringLengthTests: XCTestCase {
    func test__string_length_values() {
        expect_source("\"Hello, World!\".length", yields: 13)
        expect_source("\"Кириллица\".length", yields: 9)
        expect_source("\"🤣\".length", yields: 1)
        expect_source("\"\".length", yields: 0)
    }
}
