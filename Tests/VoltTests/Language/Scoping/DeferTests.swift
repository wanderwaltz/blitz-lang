import XCTest

final class DeferTests: XCTestCase {
    func test_deferred_statements_are_performed_after_block_statements() {
        expect_source(
            """
            {
                defer {
                    print "deferred"
                }

                print "normal"
            }
            """,
            prints: ["normal", "deferred"]
        )

        expect_source(
            """
            {
                print "normal"

                defer {
                    print "deferred"
                }
            }
            """,
            prints: ["normal", "deferred"]
        )
    }

    func test_multiple_deferred_statements_are_performed_in_reverse_order() {
        expect_source(
            """
            {
                defer {
                    print "1"
                }

                print "normal"

                defer {
                    print "2"
                }
            }
            """,
            prints: ["normal", "2", "1"]
        )
    }

    func test_deferred_statements_are_performed_after_return() {
        expect_source(
            """
            func do_print(_ arg) {
                print arg
            }

            func check() {
                defer {
                    print "1"
                }

                defer {
                    print "2"
                }

                return do_print("returned")
            }
            check()
            """,
            prints: ["returned", "2", "1"]
        )
    }
}
