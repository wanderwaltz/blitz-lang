protocol Callable {
    func call(interpreter: ASTInterpreter, signature: CallSignature, arguments: [Value]) throws -> Value
}
