import XCTest

/// This test case assumes the default String delegate is set up
final class StringIsEmptyTests: XCTestCase {
    func test__string_isEmpty_values() {
        expect_source("\"Hello, World!\".isEmpty", yields: false)
        expect_source("\"Кириллица\".isEmpty", yields: false)
        expect_source("\"🤣\".isEmpty", yields: false)
        expect_source("\"\".isEmpty", yields: true)
    }
}
