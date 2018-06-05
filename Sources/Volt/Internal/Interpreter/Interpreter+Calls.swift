extension Interpreter {
    func lookupCallable(for callee: Expression) throws -> Callable {
        let calleeValue = try evaluate(callee)

        switch calleeValue {
        case let .object(callable as Callable):
            return callable

        default:
            throw RuntimeError.invalidCallee(calleeValue)
        }
    }
}
