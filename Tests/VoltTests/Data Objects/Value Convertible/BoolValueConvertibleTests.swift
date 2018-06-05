import XCTest
@testable import Volt

final class BoolValueConvertibleTests: XCTestCase {
    func test_true_to_value() {
        let value = true.voltValue

        switch value {
        case let .bool(boolValue):
            XCTAssertTrue(boolValue)

        default:
            XCTFail("expected `true` to be convertible to .bool(true)")
        }
    }

    func test_false_to_value() {
        let value = false.voltValue

        switch value {
        case let .bool(boolValue):
            XCTAssertFalse(boolValue)

        default:
            XCTFail("expected `false` to be convertible to .bool(false)")
        }
    }
}
