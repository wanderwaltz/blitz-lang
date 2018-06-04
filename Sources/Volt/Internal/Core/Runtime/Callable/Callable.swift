protocol Callable {
    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value
}
