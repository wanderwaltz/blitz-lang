extension InterpreterResult {
    func flatMap(_ mapping: (Value) -> InterpreterResult) -> InterpreterResult {
        switch self {
        case let .value(value):
            return mapping(value)

        case .runtimeError, .throwable:
            return self
        }
    }
}
