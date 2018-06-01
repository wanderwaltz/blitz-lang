import XCTest

/// This test case assumes the default String delegate is set up
final class StringTrimmedTests: XCTestCase {
    func test__string_trimmed_values() {
        expect_source("\"    Hello, World! \".trimmed()", yields: "Hello, World!")
        expect_source("\"  Кириллица        \".trimmed()", yields: "Кириллица")
        expect_source("\" 🤣 \".trimmed()", yields: "🤣")
        expect_source("\"               \".trimmed()", yields: "")
    }
}
