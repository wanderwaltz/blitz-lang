extension ASTInterpreterResult {
    func flatMap(_ mapping: (Value) -> ASTInterpreterResult) -> ASTInterpreterResult {
        switch self {
        case let .value(value):
            return mapping(value)

        case .runtimeError, .throwable:
            return self
        }
    }
}
