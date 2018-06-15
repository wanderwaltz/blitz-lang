import XCTest
@testable import Blitz

final class ForeignClassPropertySettersTests: ForeignClassTestCase {
    func testThat__property_values_for_builtin_types_are_written_ok() {
        let foo = MutableWithVariousProperties()

        vm.defineGlobal(named: "foo", value: foo)

        run_source("foo.pInt    = -1"); XCTAssertEqual(foo.pInt,    -1)
        run_source("foo.pInt8   = -2"); XCTAssertEqual(foo.pInt8,   -2)
        run_source("foo.pInt16  = -3"); XCTAssertEqual(foo.pInt16,  -3)
        run_source("foo.pInt32  = -4"); XCTAssertEqual(foo.pInt32,  -4)
        run_source("foo.pInt64  = -5"); XCTAssertEqual(foo.pInt64,  -5)
        run_source("foo.pUInt   = 11"); XCTAssertEqual(foo.pUInt,   11)
        run_source("foo.pUInt8  = 12"); XCTAssertEqual(foo.pUInt8,  12)
        run_source("foo.pUInt16 = 13"); XCTAssertEqual(foo.pUInt16, 13)
        run_source("foo.pUInt32 = 14"); XCTAssertEqual(foo.pUInt32, 14)
        run_source("foo.pUInt64 = 15"); XCTAssertEqual(foo.pUInt64, 15)

        run_source("foo.pFloat  = -1")
        XCTAssertEqual(foo.pFloat,  Float(-1), accuracy: Float(FLOAT_TOLERANCE))

        run_source("foo.pDouble = -2")
        XCTAssertEqual(foo.pDouble, Double(-2), accuracy: Double(FLOAT_TOLERANCE))

        run_source("foo.pTrue = false"); XCTAssertFalse(foo.pTrue)
        run_source("foo.pFalse = true"); XCTAssertTrue(foo.pFalse)

        run_source("foo.pIntArray = [-8, 16, -32, 64]")
        XCTAssertEqual(foo.pIntArray, [-8, 16, -32, 64])

        run_source("foo.pStringArray = [\"z\", \"x\", \"c\", \"v\", \"b\"]")
        XCTAssertEqual(foo.pStringArray, ["z", "x", "c", "v", "b"])

        run_source("foo.pNilArray = [\"z\", \"x\", \"c\", \"v\", \"b\"]")
        XCTAssertEqual(foo.pNilArray ?? [], ["z", "x", "c", "v", "b"])
    }
}
