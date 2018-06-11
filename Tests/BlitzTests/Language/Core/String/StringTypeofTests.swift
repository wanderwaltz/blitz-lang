import XCTest

final class StringTypeofTests: XCTestCase {
    func test__typeof_string_is_string() {
        expect_source("type(of: \"\")", yields: "String")
        expect_source("type(of: \"Hello\")", yields: "String")
    }
}
