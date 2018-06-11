import XCTest

final class ForStatementTests: XCTestCase {
    func testThat__it_runs_while_expression_is_truthy() {
        expect_source(
            """
            var i = 0
            for (i = 0; i < 3; i += 1) {

            }
            i
            """,
            yields: 3
        )
    }

    func testThat__it_allows_declaring_loop_variable_inline() {
        expect_source(
            """
            var k = ""
            for (var i = 0; i < 3; i += 1) {
                k += i
            }
            k
            """,
            yields: "012"
        )
    }

    func testThat__it_creates_a_scope() {
        expect_source(
            """
            var a = 123
            for (var i = 0; i < 3; i += 1) {
                var a = 5
            }
            a
            """,
            yields: 123
        )
    }

    func testThat__it_returns_the_result_of_evaluating_its_body() {
        expect_source(
            """
            for (var i = 0; i < 3; i += 1) {
                "qwerty"
            }
            """,
            yields: "qwerty"
        )
    }

    func testThat__it_does_not_evaluate_body_if_expression_is_false() {
        expect_source(
            """
            var a = 0
            for (var i = 0; i > 100; i += 1) {
                a = 1
            }
            a
            """,
            yields: 0
        )
    }

    func testThat__it_allows_literal_false_in_its_condition() {
        expect_source(
            """
            var a = 0
            for (var i = 0; false; i += 1) {
                a = 1
            }
            a
            """,
            yields: 0
        )
    }

    func testThat__it_does_not_require_an_initializer() {
        expect_source(
            """
            var i = 0
            for (; i < 3; i += 1) {}
            i
            """,
            yields: 3
        )
    }

    func testThat__it_requires_an_opening_brace() {
        expect_source(
            """
            for (var i = 0; i < 3; i += 1) print i

            """,
            yields_parse_error: "expected { after for clauses"
        )
    }

    func testThat__it_stops_running_body_if_interrupted_by_break() {
        expect_source(
            """
            var i = 0
            for (; i < 10; i += 1) {
                if i >= 5 {
                    break
                }
            }
            i
            """,
            yields: 6
        )
    }

    func testThat__it_skips_to_the_end_of_the_body_with_continue() {
        expect_source(
            """
            var i = 0
            var s = ""
            for (var i = 0; i < 5; i += 1) {
                if i == 3 {
                    continue
                }
                s += i
            }
            s
            """,
            yields: "0124"
        )
    }

    func testThat__it_allows_skipping_condition() {
        expect_source(
            """
            var a = 0
            for (var i = 0;; i += 1) {
                a += 1
                break
            }
            a
            """,
            yields: 1
        )
    }

    func testThat__it_allows_skipping_increment() {
        expect_source(
            """
            var a = 0
            for (var i = 0; i < 1;) {
                a += 1
                i = 1
            }
            a
            """,
            yields: 1
        )
    }

    func testThat__it_allows_skipping_all_clauses() {
        expect_source(
            """
            var a = 0
            for (;;) {
                a = 1
                break
            }
            a
            """,
            yields: 1
        )
    }
}
