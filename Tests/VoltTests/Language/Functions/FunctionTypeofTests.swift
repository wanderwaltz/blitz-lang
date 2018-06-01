import XCTest

final class FunctionTypeofTests: XCTestCase {
    func test__typeof_function_is_function() {
        expect_source(
            """
            func foo() {}
            type(of: foo)
            """,
            yields: "Function"
        )
    }

    func test__typeof_typeof_is_function() {
        expect_source(
            """
            type(of: type)
            """,
            yields: "Function"
        )
    }
}
