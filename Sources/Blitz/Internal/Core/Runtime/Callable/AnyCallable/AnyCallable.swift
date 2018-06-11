struct AnyCallable {
    let validCallSignatures: [CallSignature]

    init(validCallSignatures: [CallSignature],
         _ call: @escaping (CallParameters) throws -> Value) {
            self.validCallSignatures = validCallSignatures
            _call = call
    }

    private let _call: (CallParameters) throws -> Value
}


extension AnyCallable: Callable {
    func call(with parameters: CallParameters) throws -> Value {
        guard validCallSignatures.contains(parameters.signature) else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: parameters.signature)
        }

        return try _call(parameters)
    }
}
