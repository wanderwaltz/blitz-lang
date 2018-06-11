protocol Subscriptable {
    var validCallSignatures: [CallSignature] { get }

    func `subscript`(with parameters: SubscriptParameters) throws -> Value
}
