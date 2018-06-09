protocol Callable {
    var validCallSignatures: [CallSignature] { get }

    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value
}
