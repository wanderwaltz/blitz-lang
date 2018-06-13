final class InterpreterEnvironment {
    typealias Result = InterpreterResult
    typealias RuntimeValue = InterpreterRuntimeValue

    let parent: InterpreterEnvironment?

    init(parent: InterpreterEnvironment? = nil) {
        self.parent = parent
    }

    private(set) var values: [String:RuntimeValue] = [:]
}


// MARK: - working with variables
extension InterpreterEnvironment {
    func defineVariable(named name: Token, value: Value, isMutable: Bool) throws {
        switch value {
        case let .object(function as Function):
            try defineOverloadedFunction(named: name, with: function)

        default:
            guard values[name.lexeme] == nil else {
                throw error(.invalidRedefenition, "'\(name)' is already defined", name.location)
            }

            forceDefineVariable(named: name, value: value, isMutable: isMutable)
        }
    }

    func defineOverloadedFunction(named name: Token, with callable: Callable) throws {
        guard let existingValue = values[name.lexeme] else {
            // just define a variable if there is no values with the same name
            forceDefineVariable(named: name, value: .object(callable), isMutable: false)
            return
        }

        guard case let .object(existingFunction as Callable) = existingValue.value else {
            // it is only allowed to overload functions with functions
            throw error(.invalidRedefenition, "'\(name)' is already defined", name.location)
        }

        let overloaded = try OverloadedCallable([existingFunction, callable])
        forceDefineVariable(named: name, value: .init(overloaded), isMutable: false)
    }

    /// Force version does not throw if the variable is already defined;
    /// As a side effect this also allows redefining `let` constants.
    func forceDefineVariable(named name: Token, value: Value, isMutable: Bool) {
        values[name.lexeme] = RuntimeValue(value: value, isMutable: isMutable)
    }

    func get(_ name: Token) throws -> Value {
        if let value = values[name.lexeme] {
            return value.value
        }

        if let parent = parent {
            return try parent.get(name)
        }

        throw error(.unknownIdentifier, "unknown identifier '\(name)'", name.location)
    }

    func get(at depth: Int, _ name: Token) throws -> Value {
        if let ancestor = self.ancestor(depth: depth) {
            return try ancestor.get(name)
        }
        else {
            throw error(
                .unknownIdentifier,
                "invalid environment depth \(depth) for identifier '\(name)'",
                name.location
            )
        }
    }

    func set(_ name: Token, value newValue: Value) throws -> Value {
        guard let value = values[name.lexeme] else {
            if let parent = parent {
                return try parent.set(name, value: newValue)
            }

            throw error(.unknownIdentifier, "unknown identifier '\(name)'", name.location)
        }

        guard value.isMutable else {
            throw error(.settingImmutableValue, "cannot set a let constant '\(name)'", name.location)
        }

        values[name.lexeme] = RuntimeValue(value: newValue, isMutable: value.isMutable)

        return newValue
    }

    func set(at depth: Int, _ name: Token, value newValue: Value) throws -> Value {
        if let ancestor = self.ancestor(depth: depth) {
            return try ancestor.set(name, value: newValue)
        }
        else {
            throw error(
                .unknownIdentifier,
                "invalid environment depth \(depth) for identifier '\(name)'",
                name.location
            )
        }
    }
}


extension InterpreterEnvironment {
    private func ancestor(depth: Int) -> InterpreterEnvironment? {
        var result: InterpreterEnvironment? = self

        for _ in 0..<depth {
            result = result?.parent
        }

        return result
    }
}


// MARK: - errors
extension InterpreterEnvironment {
    private func error(_ code: RuntimeError.Code, _ message: String, _ location: SourceLocation) -> RuntimeError {
        return RuntimeError(code: code, message: message, location: location)
    }
}
