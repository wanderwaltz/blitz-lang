import XCTest

final class IntegerTypeofTests: XCTestCase {
    func test__typeof_float_is_number() {
        expect_source("type(of: 1)", yields: "Number")
        expect_source("type(of: 42)", yields: "Number")
        expect_source("type(of: -1023)", yields: "Number")
    }
}
