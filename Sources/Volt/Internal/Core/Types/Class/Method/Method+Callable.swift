extension Method: Callable {
    var validCallSignatures: [CallSignature] {
        return [unboundCallSignature]
    }

    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard signature == unboundCallSignature else {
            throw RuntimeError.invalidCallSignature(expected: unboundCallSignature, got: signature)
        }

        guard arguments.count == 1 else {
            throw RuntimeError.invalidNumberOfArguments(expected: unboundArity, got: arguments.count)
        }

        let arg = arguments[0]

        guard let instance = typecast<InstanceType>.any(arg.any) else {
            throw RuntimeError.typeError(expected: InstanceType.self, got: arg.typeName)
        }

        return .object(try bind(to: instance))
    }
}
