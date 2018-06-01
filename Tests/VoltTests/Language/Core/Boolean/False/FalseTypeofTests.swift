import XCTest

final class FalseTypeofTests: XCTestCase {
    func test__typeof_false_is_bool() {
        expect_source("type(of: false)", yields: "Bool")
    }
}
