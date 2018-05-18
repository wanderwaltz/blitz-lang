struct AnyCallable {
    init(_ call: @escaping (ASTInterpreter, [Value]) throws -> Value) {
        _call = call
    }

    private let _call: (ASTInterpreter, [Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(interpreter: ASTInterpreter, arguments: [Value]) throws -> Value {
        return try _call(interpreter, arguments)
    }
}
