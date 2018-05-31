import XCTest

final class FunctionReturnValueTests: XCTestCase {
    func test_function_returning_string() {
        expect_source(
            """
            func test() {
                return "some_string"
            }
            test()
            """,
            yields: "some_string"
        )
    }

    func test_function_returning_string_without_explicit_return() {
        expect_source(
            """
            func test() {
                "some_string"
            }
            test()
            """,
            yields: "some_string"
        )
    }

    func test_function_returning_number() {
        expect_source(
            """
            func test() {
                return 123
            }
            test()
            """,
            yields: 123
        )
    }

    func test_function_returning_number_without_explicit_return() {
        expect_source(
            """
            func test() {
                123
            }
            test()
            """,
            yields: 123
        )
    }

    func test_function_returning_bool() {
        expect_source(
            """
            func test() {
                return false
            }
            test()
            """,
            yields: false
        )
    }

    func test_function_returning_bool_without_explicit_return() {
        expect_source(
            """
            func test() {
                false
            }
            test()
            """,
            yields: false
        )
    }

    func test_function_returning_nil() {
        expect_source_yields_nil(
            """
            func test() {
                return nil
            }
            test()
            """
        )
    }

    func test_function_returning_nil_without_explicit_return() {
        expect_source_yields_nil(
            """
            func test() {
                nil
            }
            test()
            """
        )
    }

    func test_empty_function_returns_nil() {
        expect_source_yields_nil(
            """
            func test() {

            }
            test()
            """
        )
    }
}
