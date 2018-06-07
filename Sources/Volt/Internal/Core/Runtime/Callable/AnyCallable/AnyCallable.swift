struct AnyCallable {
    let signature: CallSignature

    init(signature: CallSignature,
         _ call: @escaping (Interpreter, CallSignature, [Value]) throws -> Value) {
            self.signature = signature
            _call = call
    }

    private let _call: (Interpreter, CallSignature, [Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard signature == self.signature else {
            throw RuntimeError.invalidCallSignature(expected: self.signature, got: signature)
        }

        return try _call(interpreter, signature, arguments)
    }
}
