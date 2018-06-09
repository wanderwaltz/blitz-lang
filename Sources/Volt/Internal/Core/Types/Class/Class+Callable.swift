extension Class: Callable {
    var validCallSignatures: [CallSignature] {
        return initializer.validBoundCallSignatures
    }

    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard validCallSignatures.contains(signature) else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: signature)
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
