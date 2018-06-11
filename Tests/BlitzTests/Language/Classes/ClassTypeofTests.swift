import XCTest

final class ClassTypeofTests: XCTestCase {
    func test__typeof_class_is_class_type() {
        expect_source(
            """
            class Foo {}
            type(of: Foo)
            """,
            yields: "Foo.Type"
        )
    }

    func test__typeof_instance_is_class() {
        expect_source(
            """
            class Foo {}
            type(of: Foo())
            """,
            yields: "Foo"
        )
    }
}
