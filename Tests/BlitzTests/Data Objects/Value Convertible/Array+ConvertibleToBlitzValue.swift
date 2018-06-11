import XCTest
@testable import Blitz

final class ArrayConvertibleToBlitzValueTests: XCTestCase {
    func test_string_to_value() {
        validate_array_convertible([Int]())
        validate_array_convertible([1, 2, 3])
        validate_array_convertible(["a", "b", "c"])
        validate_array_convertible([true, true, false])
        validate_array_convertible([1, "q", false])
    }

    private func validate_array_convertible<T>(_ array: [T], file: StaticString = #file, line: UInt = #line) {
        let value = array.blitzValue

        switch value {
        case let .array(values):
            XCTAssertEqual(values, array.map({ Value($0) }), file: file, line: line)

        default:
            XCTFail("expected [\(String(describing: T.self))] to be convertible to .array")
        }
    }
}
