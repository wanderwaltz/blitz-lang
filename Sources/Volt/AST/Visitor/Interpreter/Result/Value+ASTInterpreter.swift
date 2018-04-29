extension Value {
    var boolValue: Bool {
        switch self {
        case .nil: return false
        case let .bool(value): return value
        case let .number(value): return value != 0
        case let .string(value): return !value.isEmpty
        }
    }

    var stringValue: String {
        return description
    }
}

prefix func ! (value: Value) -> ASTInterpreterResult {
    return .value(.bool(!value.boolValue))
}

prefix func - (value: Value) -> ASTInterpreterResult {
    switch value {
    case let .number(value):
        return .value(.number(-value))

    default:
        return unaryOperator("-", isNotApplicableTo: value.typeName)
    }
}

func + (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.number(ln + rn))
    case let (.string(ls), _): return .value(.string(ls + right.stringValue))
    case let (_, .string(rs)): return .value(.string(left.stringValue + rs))
    default:
        return binaryOperator("+", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func - (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.number(ln - rn))
    default:
        return binaryOperator("-", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func * (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.number(ln * rn))
    default:
        return binaryOperator("*", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func / (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.number(ln / rn))
    default:
        return binaryOperator("/", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func > (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.bool(ln > rn))
    default:
        return binaryOperator(">", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func >= (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.bool(ln >= rn))
    default:
        return binaryOperator(">=", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func < (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.bool(ln < rn))
    default:
        return binaryOperator("<", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

func <= (left: Value, right: Value) -> ASTInterpreterResult {
    switch (left, right) {
    case let (.number(ln), .number(rn)): return .value(.bool(ln <= rn))
    default:
        return binaryOperator("<=", isNotApplicableTo: left.typeName, and: right.typeName)
    }
}

private func unaryOperator(_ op: String, isNotApplicableTo type: String) -> ASTInterpreterResult {
    return .runtimeError(.init(code: .typeError, message: "operator \(op) is not applicable to \(type)"))
}

private func binaryOperator(_ op: String, isNotApplicableTo left: String, and right: String) -> ASTInterpreterResult {
    return .runtimeError(.init(code: .typeError, message: "operator \(op) is not applicable to \(left) and \(right)"))
}
