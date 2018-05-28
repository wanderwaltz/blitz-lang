extension Class: Callable {
    func call(interpreter: ASTInterpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard arguments.count == arity else {
            throw InternalError.invalidNumberOfArguments(expected: arity, got: arguments.count)
        }

        return .object(Instance(klass: self))
    }
}
