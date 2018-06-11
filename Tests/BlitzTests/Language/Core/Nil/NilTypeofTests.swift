import XCTest

final class NilTypeofTests: XCTestCase {
    func test__typeof_nil_is_nil() {
        expect_source("type(of: nil)", yields: "nil")
    }
}
