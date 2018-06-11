extension AnyCallable {
    init(signature: CallSignature,
         _ call: @escaping (CallParameters) throws -> Value) {
            self.init(
                validCallSignatures: [signature],
                call
            )
    }
}
