import XCTest

final class TypeOfTypeofTests: XCTestCase {
    func test__typeof_returns_string() {
        expect_source("type(of: type(of: 123))", yields: "String")
        expect_source("type(of: type(of: -1.23))", yields: "String")
        expect_source("type(of: type(of: true))", yields: "String")
        expect_source("type(of: type(of: false))", yields: "String")
        expect_source("type(of: type(of: nil))", yields: "String")
        expect_source("type(of: type(of: \"Hello\"))", yields: "String")
    }
}
