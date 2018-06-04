extension ASTInterpreter {
    func captureValue(of block: () throws -> Value) -> Result {
        return captureResult(of: { .value(try block()) })
    }

    func captureResult(of block: () throws -> Result) -> Result {
        do {
            return try block()
        }
        catch let error as RuntimeError {
            return .runtimeError(error)
        }
        catch let command as ThrowableCommand {
            return .throwable(command)
        }
        catch let error {
            preconditionFailure("unexpected error received: \(error)")
        }
    }

    func unwrap(_ result: Result) throws -> Value {
        switch result {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        case let .throwable(command): throw command
        }
    }
}
