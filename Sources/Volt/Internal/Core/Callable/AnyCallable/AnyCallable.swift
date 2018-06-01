struct AnyCallable {
    init(_ call: @escaping (ASTInterpreter, CallSignature, [Value]) throws -> Value) {
        _call = call
    }

    private let _call: (ASTInterpreter, CallSignature, [Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(interpreter: ASTInterpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        return try _call(interpreter, signature, arguments)
    }
}
