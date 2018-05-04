import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/language/while_spec.rb
final class WhileStatementTests: XCTestCase {
    func testThat__it_runs_while_expression_is_truthy() {
        expect_source(
            """
            var i = 0
            while i < 3 {
                i += 1
            }
            i
            """,
            yields: 3
        )
    }

    func testThat__it_allows_body_to_begin_on_the_same_line_as_opening_brace() {
        expect_source(
            """
            var i = 0
            while i < 3 { i += 1
            }
            i
            """,
            yields: 3
        )
    }

    func testThat__it_creates_a_scope() {
        expect_source(
            """
            var i = 0
            var a = 123
            while i < 3 {
                i += 1
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
            var i = 0
            while i < 3 {
                i += 1
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
            while false {
                a = 1
            }
            a
            """,
            yields: 0
        )
    }

    func testThat__it_requires_an_expression() {
        expect_source(
            """
            var a = 0
            while {
                a = 1
            }
            a
            """,
            yields_parse_error: "expected expression"
        )
    }

    func testThat__it_requires_an_opening_brace() {
        expect_source(
            """
            var i = 0
            while i < 3 i += 1
            """,
            yields_parse_error: "expected { after while"
        )
    }

    func testThat__it_stops_running_body_if_interrupted_by_break() {
        expect_source(
            """
            var i = 0
            while i < 10 {
                i += 1
                if i > 5 {
                    break
                }
            }
            i
            """,
            yields: 6
        )
    }

    func testThat__it_stops_running_body_if_interrupted_by_break_in_a_nested_scope() {
        expect_source(
            """
            var i = 0
            while i < 10 {
                i += 1
                {
                    if i > 5 {
                        break
                    }
                }
            }
            i
            """,
            yields: 6
        )
    }

    func testThat__it_returns_nil_when_interrupted_by_break() {
        expect_source_yields_nil(
            """
            var i = 0
            while true {
                i += 1
                break
            }
            """
        )
    }

    func testThat__it_skips_to_then_end_of_the_body_with_continue() {
        expect_source(
            """
            var i = 0
            var s = ""
            while i < 5 {
                i += 1
                if i == 3 {
                    continue
                }
                s += i
            }
            s
            """,
            yields: "1245"
        )
    }
}
