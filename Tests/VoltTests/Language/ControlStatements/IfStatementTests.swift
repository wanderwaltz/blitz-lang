import XCTest

/// Test cases inspired by https://github.com/ruby/spec/blob/master/language/if_spec.rb
final class IfStatementTests: XCTestCase {
    func testThat__it_evaluates_body_if_expression_is_true() {
        expect_source(
            """
            var result = ""
            if true {
                result += 1
            }
            result
            """,
            yields: "1"
        )
    }

    func testThat__it_does_not_evaluate_body_if_expression_is_false() {
        expect_source(
            """
            var result = ""
            if false {
                result += 1
            }
            result
            """,
            yields: ""
        )
    }

    func testThat__it_does_not_evaluate_else_body_if_expression_is_true() {
        expect_source(
            """
            var result = ""
            if true {
                result += 1
            }
            else {
                result += 2
            }
            result
            """,
            yields: "1"
        )
    }

    func testThat__it_evaluates_else_body_if_expression_is_false() {
        expect_source(
            """
            var result = ""
            if false {
                result += 1
            }
            else {
                result += 2
            }
            result
            """,
            yields: "2"
        )
    }

    func testThat__it_returns_the_result_of_then_body_evaluation_if_expression_is_true() {
        expect_source(
            """
            if true {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_returns_the_result_of_the_last_then_body_statement_if_expression_is_true() {
        expect_source(
            """
            if true {
                1
                2
                3
            }
            """,
            yields: 3
        )
    }

    func testThat__it_returns_nil_if_expression_is_false() {
        expect_source_yields_nil(
            """
            if false {
                1
            }
            """
        )
    }

    func testThat__it_returns_the_result_of_else_body_evaluation_if_expression_is_false() {
        expect_source(
            """
            if false {
                1
            }
            else {
                2
            }
            """,
            yields: 2
        )
    }

    func testThat__it_returns_the_result_of_the_last_else_body_statement_if_expression_is_false() {
        expect_source(
            """
            if false {
                1
            }
            else {
                2
                3
                4
            }
            """,
            yields: 4
        )
    }

    func testThat__it_returns_the_result_of_then_body_evaluation_if_expression_is_true_and_else_is_present() {
        expect_source(
            """
            if true {
                1
            }
            else {
                2
            }
            """,
            yields: 1
        )
    }

    func testThat__it_returns_nil_if_then_body_is_empty_and_expression_is_true() {
        expect_source_yields_nil(
            """
            if true {}
            """
        )
    }

    func testThat__it_returns_nil_if_else_body_is_empty_and_expression_is_false() {
        expect_source_yields_nil(
            """
            if false {
                1
            }
            else {}
            """
        )
    }

    func testThat__it_returns_nil_if_then_and_else_bodies_are_empty_and_expression_is_true() {
        expect_source_yields_nil(
            """
            if true {}
            else {}
            """
        )
    }

    func testThat__it_returns_nil_if_then_and_else_bodies_are_empty_and_expression_is_false() {
        expect_source_yields_nil(
            """
            if false {}
            else {}
            """
        )
    }

    func testThat__it_considers_a_nonempty_string_as_true() {
        expect_source(
            """
            if "qwerty" {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_considers_an_empty_string_as_false() {
        expect_source(
            """
            if "" {
                1
            }
            else {
                2
            }
            """,
            yields: 2
        )
    }

    func testThat__it_considers_a_positive_integer_as_true() {
        expect_source(
            """
            if 123 {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_considers_a_negative_integer_as_true() {
        expect_source(
            """
            if -123 {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_considers_a_zero_integer_as_false() {
        expect_source(
            """
            if 0 {
                1
            }
            else {
                2
            }
            """,
            yields: 2
        )
    }

    func testThat__it_considers_a_positive_float_as_true() {
        expect_source(
            """
            if 12.3 {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_considers_a_negative_float_as_true() {
        expect_source(
            """
            if -1.23 {
                1
            }
            """,
            yields: 1
        )
    }

    func testThat__it_considers_a_zero_float_as_false() {
        expect_source(
            """
            if 0.0 {
                1
            }
            else {
                2
            }
            """,
            yields: 2
        )
    }

    func testThat__it_requires_braces_for_then_body() {
        expect_source(
            """
            if true 1
            """,
            yields_parse_error: "expected { after if condition"
        )
    }

    func testThat__it_requires_braces_for_else_body() {
        expect_source(
            """
            if false {}
            else 1
            """,
            yields_parse_error: "expected { or if after else"
        )
    }

    func testThat__it_evaluates_subsequent_else_if_statements_and_executes_body_of_the_first_match() {
        expect_source(
            """
            if false {
                1
            }
            else if true {
                2
            }
            else {
                3
            }
            """,
            yields: 2
        )
    }

    func testThat__it_executes_else_body_if_no_if_or_else_if_statements_match() {
        expect_source(
            """
            if false {
                1
            }
            else if false {
                2
            }
            else {
                3
            }
            """,
            yields: 3
        )
    }

    func testThat__it_evaluates_then_body_in_containing_scope() {
        expect_source(
            """
            let a = 123
            if true {
                a + 1
            }
            """,
            yields: 124
        )
    }

    func testThat__it_evaluates_else_body_in_containing_scope() {
        expect_source(
            """
            let a = 123
            if false {
                a + 1
            }
            else {
                a + 2
            }
            """,
            yields: 125
        )
    }

    func testThat__it_evaluates_else_if_body_in_containing_scope() {
        expect_source(
            """
            let a = 123
            if false {
                a + 1
            }
            else if true {
                a + 2
            }
            else {
                a + 3
            }
            """,
            yields: 125
        )
    }
}
