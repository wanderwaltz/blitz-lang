import XCTest

final class X_AssignmentTests: XCTestCase {
    func test_assignment() {
        expect_source(
            """
            var x = 4
            x = 13
            x
            """,
            yields: 13
        )

        expect_source(
            """
            class Foo { var x = 4 }
            let foo = Foo()
            foo.x = 13
            foo.x
            """,
            yields: 13
        )
    }

    func test_plus_assignment() {
        expect_source(
            """
            var x = 4
            x += 5
            x
            """,
            yields: 9
        )

        expect_source(
            """
            class Foo { var x = 4 }
            let foo = Foo()
            foo.x += 5
            foo.x
            """,
            yields: 9
        )
    }

    func test_minus_assignment() {
        expect_source(
            """
            var x = 4
            x -= 5
            x
            """,
            yields: -1
        )

        expect_source(
            """
            class Foo { var x = 4 }
            let foo = Foo()
            foo.x -= 5
            foo.x
            """,
            yields: -1
        )
    }

    func test_slash_assignment() {
        expect_source(
            """
            var x = 8
            x /= 2
            x
            """,
            yields: 4
        )

        expect_source(
            """
            class Foo { var x = 8 }
            let foo = Foo()
            foo.x /= 2
            foo.x
            """,
            yields: 4
        )
    }

    func test_star_assignment() {
        expect_source(
            """
            var x = 4
            x *= 5
            x
            """,
            yields: 20
        )

        expect_source(
            """
            class Foo { var x = 4 }
            let foo = Foo()
            foo.x *= 5
            foo.x
            """,
            yields: 20
        )
    }
}
