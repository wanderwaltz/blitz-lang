import XCTest
@testable import Volt

final class CharacterTests: XCTestCase {
    func testThat__isDigit__returns_true__for_digits() {
        XCTAssertTrue("0".first!.isDigit)
        XCTAssertTrue("1".first!.isDigit)
        XCTAssertTrue("2".first!.isDigit)
        XCTAssertTrue("3".first!.isDigit)
        XCTAssertTrue("4".first!.isDigit)
        XCTAssertTrue("5".first!.isDigit)
        XCTAssertTrue("6".first!.isDigit)
        XCTAssertTrue("7".first!.isDigit)
        XCTAssertTrue("8".first!.isDigit)
        XCTAssertTrue("9".first!.isDigit)
    }

    func testThat__isDigit__returns_false__for_non_digits() {
        XCTAssertFalse("a".first!.isDigit)
        XCTAssertFalse("-".first!.isDigit)
        XCTAssertFalse("!".first!.isDigit)
        XCTAssertFalse("Q".first!.isDigit)
        XCTAssertFalse("%".first!.isDigit)
        XCTAssertFalse("\n".first!.isDigit)
        XCTAssertFalse("ё".first!.isDigit)
    }
}
