extension Value {
    var boolValue: Bool {
        switch self {
        case .nil: return false
        case let .bool(value): return value
        case let .number(value): return value != 0
        case let .string(value): return !value.isEmpty
        }
    }

    var booleanNegated: ASTInterpreterResult {
        return .value(.bool(!boolValue))
    }

    var numericNegated: ASTInterpreterResult {
        switch self {
        case let .number(value):
            return .value(.number(-value))

        case .nil:
            return .runtimeError(.init(code: .typeError, message: "operator - is not applicable to nil"))

        case .bool:
            return .runtimeError(.init(code: .typeError, message: "operator - is not applicable to Bool"))

        case .string:
            return .runtimeError(.init(code: .typeError, message: "operator - is not applicable to String"))
        }
    }
}
