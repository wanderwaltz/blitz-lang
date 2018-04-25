final class ASTInterpreterEnvironment {
    typealias Result = ASTInterpreterResult
    typealias RuntimeError = ASTIntepreterRuntimeError
    typealias RuntimeValue = ASTInterpteterRuntimeValue

    init(parent: ASTInterpreterEnvironment? = nil) {
        self.parent = parent
    }

    private let parent: ASTInterpreterEnvironment?
    private var values: [String:RuntimeValue] = [:]
}


extension ASTInterpreterEnvironment {
    func defineVariable(named name: Token, value: Value, isMutable: Bool) throws {
        guard values[name.lexeme] == nil else {
            throw error(.invalidRedefenition, "'\(name)' is already defined")
        }

        values[name.lexeme] = RuntimeValue(value: value, isMutable: isMutable)
    }

    func get(_ name: Token) throws -> Value {
        if let value = values[name.lexeme] {
            return value.value
        }

        if let parent = parent {
            return try parent.get(name)
        }

        throw error(.unknownIdentifier, "unknown identifier '\(name)'")
    }

    func set(_ name: Token, value newValue: Value) throws -> Value {
        guard let value = values[name.lexeme] else {
            if let parent = parent {
                return try parent.set(name, value: newValue)
            }

            throw error(.unknownIdentifier, "unknown identifier '\(name)'")
        }

        guard value.isMutable else {
            throw error(.settingImmutableValue, "cannot set a let constant '\(name)'")
        }

        values[name.lexeme] = RuntimeValue(value: newValue, isMutable: value.isMutable)

        return newValue
    }
}


extension ASTInterpreterEnvironment {
    private func error(_ code: RuntimeError.Code, _ message: String) -> RuntimeError {
        return RuntimeError(code: code, message: message)
    }
}
