extension Callable {
    func checkingSignature(_ expectedSignature: CallSignature) -> AnyCallable {
        return AnyCallable({ interpeter, signature, args in
            guard signature == expectedSignature else {
                throw InternalError.invalidCallSignature(expected: expectedSignature, got: signature)
            }

            return try self.call(interpreter: interpeter, signature: signature, arguments: args)
        })
    }
}
