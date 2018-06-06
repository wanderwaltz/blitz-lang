import XCTest
@testable import Volt

final class StringConvertibleToVoltValueTests: XCTestCase {
    func test_string_to_value() {
        validate_string_convertible("")
        validate_string_convertible("qwerty")
        validate_string_convertible("all String instances are convertible to .string")
        validate_string_convertible(String(describing: type(of: self)))
    }

    private func validate_string_convertible(_ string: String, file: StaticString = #file, line: UInt = #line) {
        let value = string.voltValue

        switch value {
        case let .string(stringValue):
            XCTAssertEqual(string, stringValue, file: file, line: line)

        default:
            XCTFail("expected String to be convertible to .string")
        }
    }
}
