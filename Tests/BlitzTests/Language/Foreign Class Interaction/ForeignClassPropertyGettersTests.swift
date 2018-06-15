import XCTest
@testable import Blitz

final class ForeignClassPropertyGettersTests: ForeignClassTestCase {
    func testThat__property_values_for_builtin_types_are_read_ok() {
        let foo = ImmutableWithVariousProperties()

        vm.defineGlobal(named: "foo", value: foo)

        expect_source("foo.pInt",    yields: Number(foo.pInt))
        expect_source("foo.pInt8",   yields: Number(foo.pInt8))
        expect_source("foo.pInt16",  yields: Number(foo.pInt16))
        expect_source("foo.pInt32",  yields: Number(foo.pInt32))
        expect_source("foo.pInt64",  yields: Number(foo.pInt64))
        expect_source("foo.pUInt",   yields: Number(foo.pUInt))
        expect_source("foo.pUInt8",  yields: Number(foo.pUInt8))
        expect_source("foo.pUInt16", yields: Number(foo.pUInt16))
        expect_source("foo.pUInt32", yields: Number(foo.pUInt32))
        expect_source("foo.pUInt64", yields: Number(foo.pUInt64))

        expect_source("foo.pFloat", yields: Number(foo.pFloat), tolerance: FLOAT_TOLERANCE)
        expect_source("foo.pDouble", yields: Number(foo.pDouble), tolerance: FLOAT_TOLERANCE)

        expect_source("foo.pString", yields: foo.pString)

        expect_source("foo.pTrue", yields: foo.pTrue)
        expect_source("foo.pFalse", yields: foo.pFalse)

        expect_source("foo.pIntArray", yields: foo.pIntArray)
        expect_source("foo.pStringArray", yields: foo.pStringArray)

        expect_source_yields_nil("foo.pNilArray")
    }
}
