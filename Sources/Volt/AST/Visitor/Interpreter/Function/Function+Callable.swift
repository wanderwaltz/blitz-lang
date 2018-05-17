extension Function: Callable {
    func call(interpreter: ASTInterpreter, arguments: [Value]) throws -> Value {
        guard arguments.count == arity else {
            throw InternalError.invalidNumberOfArguments(expected: arity, got: arguments.count)
        }

        let environment = ASTInterpreterEnvironment(parent: closure)

        for i in 0..<arity {
            let parameter = declaration.parameters[i]
            let value = arguments[i]

            try environment.defineVariable(named: parameter, value: value, isMutable: false)
        }

        let result = interpreter.executeBlock(declaration.body, environment: environment)

        switch result {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        case let .throwable(command):
            switch command {
            case let .return(value):
                return value

            default:
                throw command
            }
        }
    }
}