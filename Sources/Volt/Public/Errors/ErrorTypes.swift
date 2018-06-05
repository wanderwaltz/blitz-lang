public typealias ParserError = GenericError<ParserErrorCode>
public typealias ResolverError = GenericError<ResolverErrorCode>
public typealias RuntimeError = GenericError<RuntimeErrorCode>
public typealias ScannerError = GenericError<ScannerErrorCode>


extension GenericError where _Code == RuntimeErrorCode {
    static func arrayIndex(_ index: Int, outOf bounds: CountableRange<Int>) -> GenericError {
        return .init(
            code: .arrayIndexOutOfBounds,
            message: "index \(index) is out of bounds: \(bounds)"
        )
    }

    static func cannotImportModule(named name: String, reason: String? = nil) -> GenericError {
        var message = "cannot import module '\(name)'"

        if let reason = reason {
            message += ": \(reason)"
        }

        return .init(
            code: .cannotImportModule,
            message: message
        )
    }

    static func cannotPrint(_ value: Value, reason: String? = nil) -> GenericError {
        var message = "cannot print '\(value)'"

        if let reason = reason {
            message += ": \(reason)"
        }

        return .init(
            code: .cannotPrint,
            message: message
        )
    }

    static func invalidCallee(_ callee: Value) -> GenericError {
        return .init(
            code: .invalidCallee,
            message: "cannot call \(callee)"
        )
    }

    static func invalidCallSignature(expected: CallSignature, got: CallSignature) -> GenericError {
        return .init(
            code: .invalidCallSignature,
            message: "invalid call signature: expected '\(expected)', got: '\(got)'"
        )
    }

    static func invalidGetProperty(of object: Value, reason: String? = nil) -> GenericError {
        var message = "cannot read properties of type '\(object.typeName)'"

        if let reason = reason {
            message += ": \(reason)"
        }

        return .init(
            code: .invalidGetExpression,
            message: message
        )
    }

    static func invalidNumberOfArguments(expected: Int, got: Int) -> GenericError {
        return .init(
            code: .invalidNumberOfArguments,
            message: "invalid number of arguments: expected \(expected), got: \(got)"
        )
    }

    static func invalidSetProperty(of object: Value, reason: String? = nil) -> GenericError {
        var message = "cannot write properties of type '\(object.typeName)'"

        if let reason = reason {
            message += ": \(reason)"
        }

        return .init(
            code: .invalidSetExpression,
            message: message
        )
    }

    static func invalidSuperclass(_ superclass: Value) -> GenericError {
        return .init(
            code: .invalidSuperclass,
            message: "inheritance from non-class type \(superclass.typeName)"
        )
    }

    static func settingReadonlyProperty(named name: String) -> GenericError {
        return .init(
            code: .settingImmutableValue,
            message: "cannot set a readonly property '\(name)'"
        )
    }

    static func typeError<A, B>(expected: A, got: B) -> GenericError {
        return .init(
            code: .typeError,
            message: "type error: expected \(expected), got: \(got)"
        )
    }

    static func unknownProperty(named name: String) -> GenericError {
        return .init(
            code: .unknownProperty,
            message: "unknown property '\(name)'"
        )
    }
}
