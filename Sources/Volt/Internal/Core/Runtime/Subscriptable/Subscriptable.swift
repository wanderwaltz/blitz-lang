protocol Subscriptable {
    func `subscript`(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value
}
