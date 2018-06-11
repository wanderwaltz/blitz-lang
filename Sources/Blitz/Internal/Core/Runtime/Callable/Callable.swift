protocol Callable {
    var validCallSignatures: [CallSignature] { get }

    func call(with parameters: CallParameters) throws -> Value
}
