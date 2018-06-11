import XCTest
@testable import Blitz

final class SelectorInitWithRawValueTests: XCTestCase {
    func test_selector_without_arguments() {
        let selector = Selector(rawValue: "trimmed()")

        XCTAssertNotNil(selector)
        XCTAssertEqual(selector?.name, "trimmed")
        XCTAssertEqual(selector?.signature.components.isEmpty, true)
    }

    func test_selector_with_nonempty_labels() {
        let selector = Selector(rawValue: "init(code:message:location:)")
        XCTAssertNotNil(selector)
        XCTAssertEqual(selector?.name, "init")
        XCTAssertEqual(selector?.signature.components, ["code", "message", "location"])
    }

    func test_selector_with_some_empty_labels() {
        let selector = Selector(rawValue: "init(_:encoding:)")
        XCTAssertNotNil(selector)
        XCTAssertEqual(selector?.name, "init")
        XCTAssertEqual(selector?.signature.components, ["_", "encoding"])
    }
}
