// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import Blitz

class ForeignClassTestCase: BlitzVMTestCase {
    final class ImmutableWithVariousProperties {
        let pInt: Int = 1
        let pInt8: Int8 = 2
        let pInt16: Int16 = 3
        let pInt32: Int32 = 4
        let pInt64: Int64 = 5
        let pUInt: UInt = 6
        let pUInt8: UInt8 = 7
        let pUInt16: UInt16 = 8
        let pUInt32: UInt32 = 9
        let pUInt64: UInt64 = 10
        let pFloat: Float = 123.456
        let pDouble: Double = 789.012
        let pString: String = "qwerty"
        let pTrue: Bool = true
        let pFalse: Bool = false
        let pIntArray: [Int] = [1, 2, 3]
        let pStringArray: [String] = ["a", "b", "c"]
        let pNilArray: [String]? = nil
    }

    final class MutableWithVariousProperties {
        var pInt: Int = 1
        var pInt8: Int8 = 2
        var pInt16: Int16 = 3
        var pInt32: Int32 = 4
        var pInt64: Int64 = 5
        var pUInt: UInt = 6
        var pUInt8: UInt8 = 7
        var pUInt16: UInt16 = 8
        var pUInt32: UInt32 = 9
        var pUInt64: UInt64 = 10
        var pFloat: Float = 123.456
        var pDouble: Double = 789.012
        var pString: String = "qwerty"
        var pTrue: Bool = true
        var pFalse: Bool = false
        var pIntArray: [Int] = [1, 2, 3]
        var pStringArray: [String] = ["a", "b", "c"]
        var pNilArray: [String]? = nil
    }

    override func setUp() {
        super.setUp()

        let immutable = vm.defineClass0(initializer: ImmutableWithVariousProperties.init)
        let mutable = vm.defineClass0(initializer: MutableWithVariousProperties.init)

        immutable.registerProperty(named: "pInt", keyPath: \.pInt)
        immutable.registerProperty(named: "pInt8", keyPath: \.pInt8)
        immutable.registerProperty(named: "pInt16", keyPath: \.pInt16)
        immutable.registerProperty(named: "pInt32", keyPath: \.pInt32)
        immutable.registerProperty(named: "pInt64", keyPath: \.pInt64)
        immutable.registerProperty(named: "pUInt", keyPath: \.pUInt)
        immutable.registerProperty(named: "pUInt8", keyPath: \.pUInt8)
        immutable.registerProperty(named: "pUInt16", keyPath: \.pUInt16)
        immutable.registerProperty(named: "pUInt32", keyPath: \.pUInt32)
        immutable.registerProperty(named: "pUInt64", keyPath: \.pUInt64)
        immutable.registerProperty(named: "pFloat", keyPath: \.pFloat)
        immutable.registerProperty(named: "pDouble", keyPath: \.pDouble)
        immutable.registerProperty(named: "pString", keyPath: \.pString)
        immutable.registerProperty(named: "pTrue", keyPath: \.pTrue)
        immutable.registerProperty(named: "pFalse", keyPath: \.pFalse)
        immutable.registerProperty(named: "pIntArray", keyPath: \.pIntArray)
        immutable.registerProperty(named: "pStringArray", keyPath: \.pStringArray)
        immutable.registerProperty(named: "pNilArray", keyPath: \.pNilArray)

        mutable.registerMutableProperty(named: "pInt", keyPath: \.pInt)
        mutable.registerMutableProperty(named: "pInt8", keyPath: \.pInt8)
        mutable.registerMutableProperty(named: "pInt16", keyPath: \.pInt16)
        mutable.registerMutableProperty(named: "pInt32", keyPath: \.pInt32)
        mutable.registerMutableProperty(named: "pInt64", keyPath: \.pInt64)
        mutable.registerMutableProperty(named: "pUInt", keyPath: \.pUInt)
        mutable.registerMutableProperty(named: "pUInt8", keyPath: \.pUInt8)
        mutable.registerMutableProperty(named: "pUInt16", keyPath: \.pUInt16)
        mutable.registerMutableProperty(named: "pUInt32", keyPath: \.pUInt32)
        mutable.registerMutableProperty(named: "pUInt64", keyPath: \.pUInt64)
        mutable.registerMutableProperty(named: "pFloat", keyPath: \.pFloat)
        mutable.registerMutableProperty(named: "pDouble", keyPath: \.pDouble)
        mutable.registerMutableProperty(named: "pString", keyPath: \.pString)
        mutable.registerMutableProperty(named: "pTrue", keyPath: \.pTrue)
        mutable.registerMutableProperty(named: "pFalse", keyPath: \.pFalse)
        mutable.registerMutableProperty(named: "pIntArray", keyPath: \.pIntArray)
        mutable.registerMutableProperty(named: "pStringArray", keyPath: \.pStringArray)
        mutable.registerMutableProperty(named: "pNilArray", keyPath: \.pNilArray)
    }
}
