import XCTest
@testable import Blitz

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

    func testThat__isWhitespace__returns_true__for_whitespace_characters() {
        XCTAssertTrue(" ".first!.isWhitespace)
        XCTAssertTrue("\t".first!.isWhitespace)
    }

    func testThat__isWhitespace__returns_false__for_non_whitespace_characters() {
        XCTAssertFalse("\n".first!.isWhitespace)
        XCTAssertFalse("a".first!.isWhitespace)
        XCTAssertFalse("1".first!.isWhitespace)
    }

    func test__isNewline() {
        XCTAssertTrue("\n".first!.isNewline)
        XCTAssertFalse("\r".first!.isNewline)
    }

    func test__isPermittedForIdentifier() {
        XCTAssertTrue("a".first!.isPermittedForIdentifier)
        XCTAssertTrue("3".first!.isPermittedForIdentifier)
        XCTAssertTrue("_".first!.isPermittedForIdentifier)

        XCTAssertFalse(" ".first!.isPermittedForIdentifier)
        XCTAssertFalse("\n".first!.isPermittedForIdentifier)
        XCTAssertFalse("#".first!.isPermittedForIdentifier)
        XCTAssertFalse("+".first!.isPermittedForIdentifier)
        XCTAssertFalse("$".first!.isPermittedForIdentifier)
    }

    func test__isPermittedForFirstIdentifierSymbol() {
        XCTAssertTrue("a".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertTrue("_".first!.isPermittedForFirstIdentifierSymbol)

        XCTAssertFalse("3".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertFalse(" ".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertFalse("\n".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertFalse("#".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertFalse("+".first!.isPermittedForFirstIdentifierSymbol)
        XCTAssertFalse("$".first!.isPermittedForFirstIdentifierSymbol)
    }
}
