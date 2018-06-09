extension Interpreter {
    func performCall(with expression: CallExpression) throws -> Value {
        let callable = try lookupCallable(for: expression.callee)
        let arguments = try expression.arguments.map({ arg in
            try evaluate(arg.value)
        })

        return try callable.call(
            interpreter: self,
            signature: expression.signature,
            arguments: arguments
        )
    }

    private func lookupCallable(for callee: Expression) throws -> Callable {
        let calleeValue = try evaluate(callee)

        switch calleeValue {
        case let .object(callable as Callable):
            return callable

        default:
            throw RuntimeError.invalidCallee(calleeValue)
        }
    }
}
