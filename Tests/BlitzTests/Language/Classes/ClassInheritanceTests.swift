import XCTest

final class ClassInheritanceTests: XCTestCase {
    func test_overriding_method() {
        expect_source(
            """
            class Base {
                func method() {
                    return "base"
                }
            }

            class Derived: Base {
                func method() {
                    return "overridden"
                }
            }

            print Derived().method()
            """,
            prints: ["overridden"]
        )
    }

    func test_using_super_in_overridden_method() {
        expect_source(
            """
            class Base {
                func method() {
                    return "base"
                }
            }

            class Derived: Base {
                func method() {
                    return super.method() + " overridden"
                }
            }

            print Derived().method()
            """,
            prints: ["base overridden"]
        )
    }

    func test_overriding_readonly_computed_property() {
        expect_source(
            """
            class Base {
                var property {
                    return "base"
                }
            }

            class Derived: Base {
                var property {
                    return "overridden"
                }
            }

            print Derived().property
            """,
            prints: ["overridden"]
        )
    }

    func test_using_super_in_overridden_readonly_computed_property() {
        expect_source(
            """
            class Base {
                var property {
                    return "base"
                }
            }

            class Derived: Base {
                var property {
                    return super.property + " overridden"
                }
            }

            print Derived().property
            """,
            prints: ["base overridden"]
        )
    }

    func test_overriding_getter_in_writable_computed_property() {
        expect_source(
            """
            class Base {
                var _property = "base"

                var property {
                    get {
                        return self._property
                    }

                    set {
                        self._property = newValue
                    }
                }
            }

            class Derived: Base {
                var property {
                    get {
                        return "overridden"
                    }

                    set {

                    }
                }
            }

            print Derived().property
            """,
            prints: ["overridden"]
        )
    }

    func test_using_super_in_overridden_getter_in_writable_computed_property() {
        expect_source(
            """
            class Base {
                var _property = "base"

                var property {
                    get {
                        return self._property
                    }

                    set {
                        self._property = newValue
                    }
                }
            }

            class Derived: Base {
                var property {
                    get {
                        return super.property + " overridden"
                    }

                    set {

                    }
                }
            }

            print Derived().property
            """,
            prints: ["base overridden"]
        )
    }

    func test_overriding_setter_in_writable_computed_property() {
        expect_source(
            """
            class Base {
                var _property = "base"

                var property {
                    get {
                        return self._property
                    }

                    set {
                        self._property = newValue
                    }
                }
            }

            class Derived: Base {
                var property {
                    get {
                        return super.property
                    }

                    set {
                        super.property = newValue + " overridden"
                    }
                }
            }

            let instance = Derived()
            instance.property = "test"
            print instance.property
            """,
            prints: ["test overridden"]
        )
    }
}
