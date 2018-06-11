import XCTest

final class ClassInitializationTests: XCTestCase {
    func test_class_init_with_labeled_arguments() {
        expect_source(
            """
            class Foo {
                var a
                var b

                init(withA a, andB b) {
                    self.a = a
                    self.b = b
                }
            }

            let instance = Foo(withA: "123", andB: "456")
            print instance.a
            print instance.b
            """,
            prints: ["123", "456"]
        )
    }
}
