extension Value {
    var boolValue: Bool {
        switch self {
        case .nil: return false
        case let .bool(value): return value
        case let .number(value): return value != 0
        case let .string(value): return !value.isEmpty
        case .array: return true
        case .object: return true
        }
    }

    var stringValue: String {
        return description
    }

    var logicalNegated: InterpreterResult {
        return .value(.bool(!boolValue))
    }

    func arithmeticalNegated(at location: SourceLocation) -> InterpreterResult {
        switch self {
        case let .number(value):
            return .value(.number(-value))

        default:
            return unaryOperator("-", isNotApplicableTo: self.typeName, location)
        }
    }

    func adding(_ other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.number(ln + rn))
        case let (.string(ls), _): return .value(.string(ls + other.stringValue))
        case let (_, .string(rs)): return .value(.string(self.stringValue + rs))
        default:
            return binaryOperator("+", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func subtracting(_ other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.number(ln - rn))
        default:
            return binaryOperator("-", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func multiplying(by other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.number(ln * rn))
        default:
            return binaryOperator("*", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func dividing(by other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.number(ln / rn))
        default:
            return binaryOperator("/", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func isGreater(than other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.bool(ln > rn))
        default:
            return binaryOperator(">", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func isNotLess(than other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.bool(ln >= rn))
        default:
            return binaryOperator(">=", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func isLess(than other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.bool(ln < rn))
        default:
            return binaryOperator("<", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }

    func isNotGreater(than other: Value, at location: SourceLocation) -> InterpreterResult {
        switch (self, other) {
        case let (.number(ln), .number(rn)): return .value(.bool(ln <= rn))
        default:
            return binaryOperator("<=", isNotApplicableTo: self.typeName, and: other.typeName, location)
        }
    }
}

private func unaryOperator(_ op: String, isNotApplicableTo type: String, _ location: SourceLocation)
    -> InterpreterResult {
        return .runtimeError(
            .init(
                code: .typeError,
                message: "operator \(op) is not applicable to \(type)",
                location: location
            )
        )
}

private func binaryOperator(_ op: String, isNotApplicableTo left: String, and right: String, _ location: SourceLocation)
    -> InterpreterResult {
        return .runtimeError(
            .init(
                code: .typeError,
                message: "operator \(op) is not applicable to \(left) and \(right)",
                location: location
            )
        )
}
