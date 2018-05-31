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
}
