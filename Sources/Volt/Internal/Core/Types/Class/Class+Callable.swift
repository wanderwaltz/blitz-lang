extension Class: Callable {
    var validCallSignatures: [CallSignature] {
        return instantiator.validCallSignatures
    }

    func call(with parameters: CallParameters) throws -> Value {
        return .object(try instantiator.instantiate(klass: self, with: parameters))
    }
}
