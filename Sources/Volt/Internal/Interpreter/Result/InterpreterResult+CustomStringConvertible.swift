extension InterpreterResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .value(value): return String(describing: value)
        case let .runtimeError(error): return String(describing: error)
        case let .throwable(command): return String(describing: command)
        }
    }
}
