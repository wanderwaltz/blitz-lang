protocol Callable {
    func call(interpreter: ASTInterpreter, arguments: [Value]) throws -> Value
}
