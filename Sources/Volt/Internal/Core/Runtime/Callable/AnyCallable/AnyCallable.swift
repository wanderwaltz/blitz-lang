struct AnyCallable {
    init(_ call: @escaping (Interpreter, CallSignature, [Value]) throws -> Value) {
        _call = call
    }

    private let _call: (Interpreter, CallSignature, [Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        return try _call(interpreter, signature, arguments)
    }
}
