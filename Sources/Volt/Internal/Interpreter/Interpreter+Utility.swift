extension Interpreter {
    func captureValue(at location: SourceLocation, of block: () throws -> Value) -> Result {
        return captureResult(at: location, of: { .value(try block()) })
    }

    func captureResult(at location: SourceLocation, of block: () throws -> Result) -> Result {
        do {
            return try block()
        }
        catch let error as RuntimeError {
            return .runtimeError(error.defaultingLocation(to: location))
        }
        catch let command as ThrowableCommand {
            return .throwable(command)
        }
        catch let error {
            print(">>> \(error)")
            return .runtimeError(
                .init(
                    code: .runtimeError,
                    message: String(describing: error),
                    location: location,
                    underlyingError: error
                )
            )
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
