import XCTest

final class FunctionArgumentsTests: XCTestCase {
    func test_function_receives_its_arguments() {
        expect_source(
            """
            func test(_ a, _ b) {
                print a
                print b
            }
            test("Hello", "World")
            """,
            prints: ["Hello", "World"]
        )
    }

    func test_function_is_called_with_argument_labels() {
        expect_source(
            """
            func test(adding a, to b) {
                return a + b
            }
            test(adding: 1, to: 2)
            """,
            yields: 3
        )
    }

    func test_function_can_have_at_least_10_args() {
        expect_source(
            """
            func test(_ a0, _ a1, _ a2, _ a3, _ a4, _ a5, _ a6, _ a7, _ a8, _ a9) {
                return a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9
            }
            test(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
            """,
            yields: 55
        )
    }

    func test_function_invalid_signature_error() {
        expect_source(
            """
            func test(_ a, _ b) {
                print a
                print b
            }
            test("Hello")
            """,
            yields: .invalidCallSignature
        )

        expect_source(
            """
            func test(arg a, _ b) {
                print a
                print b
            }
            test(1, 2)
            """,
            yields: .invalidCallSignature
        )

        expect_source(
            """
            func test(_ a) {
                print a
                print b
            }
            test()
            """,
            yields: .invalidCallSignature
        )
    }
}
