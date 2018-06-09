extension AnyCallable {
    init(signature: CallSignature,
         _ call: @escaping (Interpreter, CallSignature, [Value]) throws -> Value) {
            self.init(
                validCallSignatures: [signature],
                call
            )
    }
}
