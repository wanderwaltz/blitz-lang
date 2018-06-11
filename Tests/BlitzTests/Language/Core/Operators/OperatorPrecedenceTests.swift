import XCTest

final class OperatorPrecedenceTests: XCTestCase {
    func testThat__multiplication_precedence_is_greater_than_addition() {
        expect_source("4 + 6 * 2", yields: 16)
    }

    func testThat__multiplication_precedence_is_greater_than_subtraction() {
        expect_source("4 - 6 * 2", yields: -8)
    }

    func testThat__division_precedence_is_greater_than_addition() {
        expect_source("4 + 6 / 2", yields: 7)
    }

    func testThat__division_precedence_is_greater_than_subtraction() {
        expect_source("4 - 6 / 2", yields: 1)
    }

    func testThat__multiplication_respects_parentheses() {
        expect_source("(4 + 6) * 2", yields: 20)
    }

    func testThat__division_respects_parentheses() {
        expect_source("(4 + 6) / 2", yields: 5)
    }

    /// samples generated using http://www.ii.uib.no/~wagner/hsalg/arithexp.htm
    func test__various_arithmetic_expressions() {
        expect_source(
            """
            (8 * 7 * -11 * 1 * -12 * -4 * -3 * -5 * -4 * 11 * -2 - -2) + 10 * 4 * -8 * 1 + 1 - 11 * (-6 * -3 * 5) - -1 * 5
            """,
            yields: -39031062
        )

        expect_source("-1 * 5 * 3 * -12 + 7 * (-7) * 9 * 6 * -2", yields: 5472)

        expect_source(
            """
            ((0 * -3 * 9 * -3 * 1 * (-11 + -5 * 1 * -7 * 10 * -6 * -9 * 3 * (((8 * -1) * 1 * -5) * 1 * 8 * 11 + (1 * -7 * -10) * -12 - -5 * 4 * 5 * -10 * -4 - 4 * 5 - 1 * -12 * (0 * -5 * -5 * -4 * -6 * -9 - -7 * 8 * 4 + -5 * 11 * 5 * 0 * 10 * -3 * 1 * 11 * 0 + -8 + 11 * 10) - -6)) * 5 * (-4 * -8 * -12 - (-4 - -8 - -3 * 5 + 8 * 8 * 1 * (-10) * -1 * 3 * -9 * 1 * -4 * 10 + 11 * -9 * 6 + (11 * -8 * (-4 * 0 * (6 * -10) * 1 * -11) * -10 * -10 * 8) * -8 - 8) * -3 * -7 - -1 * -9 * 8 * 8 * -8 - -1 * 9)) + -5 + -8 * 10 * 4) * -12 * -6
            """,
            yields: -23400
        )
    }

    func testThat__compariso_has_lower_precedence_than_addition() {
        expect_source("2 < 1 + 3", yields: true)
        expect_source("2 <= 1 + 3", yields: true)

        expect_source("1 > 0 + 3", yields: false)
        expect_source("1 >= 0 + 3", yields: false)
    }

    func testThat__comparison_has_lower_precedence_than_subtraction() {
        expect_source("0 - 2 < 1", yields: true)
        expect_source("0 - 2 <= 1", yields: true)

        expect_source("0 - 1 > 0", yields: false)
        expect_source("0 - 1 >= 0", yields: false)
    }

    func testThat__comparison_has_lower_precedence_than_multiplication() {
        expect_source("2 < 1 * 3", yields: true)
        expect_source("2 <= 1 * 3", yields: true)

        expect_source("2 > 1 * 3", yields: false)
        expect_source("2 >= 1 * 3", yields: false)
    }

    func testThat__comparison_has_lower_precedence_than_division() {
        expect_source("1 / 3 < 2", yields: true)
        expect_source("1 / 3 <= 2", yields: true)

        expect_source("1 / 3 > 2", yields: false)
        expect_source("1 / 3 >= 2", yields: false)
    }
}
