extension Interpreter {
    func lookupCallable(for callee: Expression, at location: SourceLocation) throws -> Callable {
        let calleeValue = try evaluate(callee)

        switch calleeValue {
        case let .object(callable as Callable):
            return callable

        default:
            throw RuntimeError(
                code: .invalidCallee,
                message: "cannot call \(callee)",
                location: location
            )
        }
    }
}
