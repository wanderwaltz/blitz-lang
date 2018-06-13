extension Function: Callable {
    var validCallSignatures: [CallSignature] {
        return [declaration.signature]
    }

    func call(with parameters: CallParameters) throws -> Value {
        guard parameters.signature == declaration.signature else {
            throw RuntimeError.invalidCallSignature(expected: declaration.signature, got: parameters.signature)
        }

        var environment = InterpreterEnvironment(parent: closure)

        for i in 0..<parameters.arguments.count {
            let parameter = declaration.parameters[i]
            let value = parameters.arguments[i]

            try environment.defineVariable(named: parameter.name, value: value, isMutable: false)
        }

        environment = InterpreterEnvironment(parent: environment)

        let result = parameters.interpreter.executeBlock(declaration.body, environment: environment)

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
