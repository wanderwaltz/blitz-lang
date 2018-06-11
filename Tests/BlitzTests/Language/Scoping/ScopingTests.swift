import XCTest

final class ScopingTests: XCTestCase {
    func test_closure_of_a_value_in_extrnal_scope() {
        expect_source(
            """
            var a = "global"

            {
                func printA() {
                    print a
                }

                printA()
                var a = "block"
                printA()
            }
            """,
            prints: ["global", "global"]
        )
    }

    func test_closure_of_a_value_in_scope() {
        expect_source(
            """
            {
                var a = 1
                func printA() {
                    print a
                }

                printA()
                a = 2
                printA()
            }
            """,
            prints: ["1", "2"]
        )
    }

    func test_object_like_closure() {
        expect_source(
            """
            func makePoint(_ x, _ y) {
              func closure(_ method) {
                if (method == "x") { return x }
                if (method == "y") { return y }
                print "unknown method " + method
              }

              return closure
            }

            var point = makePoint(2, 3)
            print point("x") // "2".
            print point("y") // "3".
            """,
            prints: ["2", "3"]
        )
    }
}
