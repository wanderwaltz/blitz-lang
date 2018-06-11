import XCTest

final class TrueTypeofTests: XCTestCase {
    func test__typeof_true_is_bool() {
        expect_source("type(of: true)", yields: "Bool")
    }
}
