extension Class: Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard arguments.count == arity else {
            throw RuntimeError.invalidNumberOfArguments(expected: arity, got: arguments.count)
        }

        let instance = Instance(klass: self)

        _ = try initializer
            .bind(to: instance)
            .call(
                interpreter: interpreter,
                signature: signature,
                arguments: arguments
            )

        return .object(instance)
    }
}
