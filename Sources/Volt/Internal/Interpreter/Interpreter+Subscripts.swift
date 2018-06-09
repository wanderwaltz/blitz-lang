extension Interpreter {
    func performSubscript(with expression: CallExpression) throws -> Value {
        let subscriptable = try lookupSubscriptable(for: expression.callee)
        let arguments = try expression.arguments.map({ arg in
            try evaluate(arg.value)
        })

        return try subscriptable.`subscript`(
            interpreter: self,
            signature: expression.signature,
            arguments: arguments
        )
    }

    private func lookupSubscriptable(for subscriptee: Expression) throws -> Subscriptable {
        let subscripteeValue = try evaluate(subscriptee)

        switch subscripteeValue {
        case let .array(values):
            return ArraySubscriptable(values)

        default:
            throw RuntimeError.invalidSubscriptee(subscripteeValue)
        }
    }
}
