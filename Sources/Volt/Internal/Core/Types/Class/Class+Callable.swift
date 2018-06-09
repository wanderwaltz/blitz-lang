extension Class: Callable {
    var validCallSignatures: [CallSignature] {
        return initializer.validBoundCallSignatures
    }

    func call(with parameters: CallParameters) throws -> Value {
        guard validCallSignatures.contains(parameters.signature) else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: parameters.signature)
        }

        let instance = Instance(klass: self)

        _ = try initializer
            .bind(to: instance)
            .call(with: parameters)

        return .object(instance)
    }
}
