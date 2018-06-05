extension Callable {
    func checkingSignature(_ expectedSignature: CallSignature) -> AnyCallable {
        return AnyCallable({ interpreter, signature, args in
            guard signature == expectedSignature else {
                throw RuntimeError.invalidCallSignature(expected: expectedSignature, got: signature)
            }

            return try self.call(interpreter: interpreter, signature: signature, arguments: args)
        })
    }
}
