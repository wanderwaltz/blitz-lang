import XCTest
@testable import Volt

final class InterpreterTests: XCTestCase {}

extension InterpreterTests {
    func test__numbers() {
        expect_source("123", yields: 123)
        expect_source("-456", yields: -456)
        expect_source("0", yields: 0)
        expect_source("0 - 5", yields: -5)
        expect_source("1 + 2", yields: 3)
        expect_source("-5 + 6", yields: 1)
        expect_source("8 / 2", yields: 4)
        expect_source("5 * 6", yields: 30)
    }

    func test__bools() {
        expect_source("true", yields: true)
        expect_source("!false", yields: true)
        expect_source("not false", yields: true)

        expect_source("false", yields: false)
        expect_source("!true", yields: false)
        expect_source("not true", yields: false)
    }

    func test__number_comparisons() {
        expect_source("1 < 2", yields: true)
        expect_source("1 <= 2", yields: true)
        expect_source("1 > 2", yields: false)
        expect_source("1 >= 2", yields: false)

        expect_source("1 <= 1", yields: true)
        expect_source("1 <= 0", yields: false)

        expect_source("1 >= 1", yields: true)
        expect_source("1 >= 0", yields: true)

        expect_source("1 > -1", yields: true)

        expect_source("1 == 1", yields: true)
        expect_source("1 == 0.5 + 0.5", yields: true)

        expect_source("1 != 2", yields: true)
    }

    func test__strings() {
        expect_source("\"qwerty\"", yields: "qwerty")
        expect_source("\"qwerty\" + \"asdfg\"", yields: "qwertyasdfg")
    }

    func test__nil() {
        expect_source_yields_nil("nil")
    }

    func test__variable_definitions() {
        expect_source("var x = 123", yields: 123)
        expect_source("let x = 123", yields: 123)
    }

    func test__variable_reading() {
        expect_source(
            """
            var x = 123
            x
            """,
            yields: 123
        )

        expect_source(
            """
            let x = 123
            x
            """,
            yields: 123
        )
    }

    func test__variable_assignment() {
        expect_source(
            """
            var x = 123
            x = 456
            x
            """,
            yields: 456
        )
    }

    func test__scopes_1() {
        expect_source(
            """
            var x = 123
            {
                var x = 456
            }
            x
            """,
            yields: 123
        )
    }

    func test__scopes_2() {
        expect_source(
            """
            var x = 123
            {
                x = 456
            }
            x
            """,
            yields: 456
        )
    }
}
