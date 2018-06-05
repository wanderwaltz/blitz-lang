import XCTest
@testable import Volt

final class SelectorDescriptionTests: XCTestCase {
    func test__selector_raw_values() {
        XCTAssertEqual(
            Selector(
                name: "trimmed",
                signature: .void
            )
            .rawValue,
            "trimmed()"
        )

        XCTAssertEqual(
            Selector(
                name: "components",
                signature: .init(
                    components: [
                        "separatedBy"
                    ]
                )
            )
            .rawValue,
             "components(separatedBy:)"
        )

        XCTAssertEqual(
            Selector(
                name: "init",
                signature: .init(
                    components: [
                        "code",
                        "message",
                        "location"
                    ]
                )
            )
            .rawValue,
             "init(code:message:location:)"
        )

        XCTAssertEqual(
            Selector(
                name: "init",
                signature: .init(
                    components: [
                        nil,
                        "encoding"
                    ]
                )
            )
            .rawValue,
             "init(_:encoding:)"
        )
    }
}
