protocol Subscriptable {
    var validCallSignatures: [CallSignature] { get }
    
    func `subscript`(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value
}
