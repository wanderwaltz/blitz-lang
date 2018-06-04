extension Function: Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard signature == declaration.signature else {
            throw InternalError.invalidCallSignature(expected: declaration.signature, got: signature)
        }

        guard arguments.count == arity else {
            throw InternalError.invalidNumberOfArguments(expected: arity, got: arguments.count)
        }

        var environment = InterpreterEnvironment(parent: closure)

        for i in 0..<arity {
            let parameter = declaration.parameters[i]
            let value = arguments[i]

            try environment.defineVariable(named: parameter.name, value: value, isMutable: false)
        }

        environment = InterpreterEnvironment(parent: environment)

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
