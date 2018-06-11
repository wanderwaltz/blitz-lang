import XCTest

final class FloatTypeofTests: XCTestCase {
    func test__typeof_float_is_number() {
        expect_source("type(of: 0.1)", yields: "Number")
        expect_source("type(of: 1.25)", yields: "Number")
        expect_source("type(of: -3.14)", yields: "Number")
    }
}
