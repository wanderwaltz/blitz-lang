struct AnyCallable {
    let validCallSignatures: [CallSignature]

    init(validCallSignatures: [CallSignature],
         _ call: @escaping (Interpreter, CallSignature, [Value]) throws -> Value) {
            self.validCallSignatures = validCallSignatures
            _call = call
    }

    private let _call: (Interpreter, CallSignature, [Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard validCallSignatures.contains(signature) else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: signature)
        }

        return try _call(interpreter, signature, arguments)
    }
}
