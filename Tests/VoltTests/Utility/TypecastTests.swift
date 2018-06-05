import XCTest
@testable import Volt

final class TypecastFromAnyTests: XCTestCase {
    func testThat__int_can_be_cast() {
        // exact type-to-type is cast ok
        XCTAssertTrue(ValidateCast<Any?, Int>(123).success)


        // different types or nils do not match
        XCTAssertFalse(ValidateCast<Any?, Int>("123").success)
        XCTAssertFalse(ValidateCast<Any?, Int>("qwerty").success)
        XCTAssertFalse(ValidateCast<Any?, Int>(nil).success)
        XCTAssertFalse(ValidateCast<Any?, Int>(NSNull()).success)


        // typecast to optional match if the types match; NSNull works as nil
        XCTAssertTrue(ValidateCast<Any?, Int?>(123).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(nil).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(NSNull()).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(Optional<Int>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(Optional<Float>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(Optional<String>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Int?>(Optional<Bool>(nilLiteral: ()) as Any).success)


        // typecast to optional still does not match if the value is non-nil and the types are different
        XCTAssertFalse(ValidateCast<Any?, Int?>("qwerty").success)
    }


    func testThat__swift_struct_can_be_cast() {
        // exact type-to-type is cast ok
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>>(AnyStruct<Int>(123)).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<String>>(AnyStruct<String>("qwerty")).success)


        // different types or nils do not match
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(123).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>("qwerty").success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(true).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(false).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(AnyStruct<String>("qwerty")).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(nil).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>>(NSNull()).success)


        // typecast to optional match if the types match; NSNull works as nil
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(AnyStruct<Int>(123)).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(nil).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(NSNull()).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(Optional<Int>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(Optional<Float>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(Optional<String>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, AnyStruct<Int>?>(Optional<Bool>(nilLiteral: ()) as Any).success)


        // typecast to optional still does not match if the value is non-nil and the types are different
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>?>(AnyStruct<String>("qwerty")).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>?>(123).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>?>("qwerty").success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>?>(true).success)
        XCTAssertFalse(ValidateCast<Any?, AnyStruct<Int>?>(false).success)
    }


    func testThat__anything_can_be_cast_to_void() {
        XCTAssertTrue(ValidateCast<Any?, Void>(123).success)
        XCTAssertTrue(ValidateCast<Any?, Void>("qwerty").success)
        XCTAssertTrue(ValidateCast<Any?, Void>(true).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(false).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(12.3).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(AnyStruct<Int>(123)).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(nil).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(NSNull()).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(Optional<Int>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(Optional<Float>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(Optional<String>(nilLiteral: ()) as Any).success)
        XCTAssertTrue(ValidateCast<Any?, Void>(Optional<Bool>(nilLiteral: ()) as Any).success)
    }
}


private struct AnyStruct<T> {
    let value: T

    init(_ value: T) {
        self.value = value
    }
}


private struct ValidateCast<From, To> {
    let success: Bool

    init(_ from: From) {
        let swift = ValidateSwiftCast<From, To>(from)
        let objc = ValidateObjectiveCCast<From, To>(from)

        success = swift.success && objc.success
    }
}


private struct ValidateSwiftCast<From, To> {
    let success: Bool

    init(_ from: From) {
        success = typecast<To>.any(from) != nil
    }
}


private struct ValidateObjectiveCCast<From, To> {
    let success: Bool

    init(_ from: From) {
        let dictionary = NSMutableDictionary()
        dictionary.setObject(from, forKey: "value" as NSString)

        success = typecast<To>.any(dictionary.object(forKey: "value" as NSString)) != nil
    }
}
