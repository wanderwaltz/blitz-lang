struct Method<_InstanceType> {
    typealias InstanceType = _InstanceType

    let unboundCallSignature = CallSignature(components: [nil])
    let validBoundCallSignatures: [CallSignature]

    init(validBoundCallSignatures: [CallSignature], bind: @escaping (InstanceType) throws -> Callable) {
        precondition(validBoundCallSignatures.count > 0)
        self.validBoundCallSignatures = validBoundCallSignatures
        _bind = bind
    }

    private let _bind: (InstanceType) throws -> Callable
}


extension Method {
    func bind(to instance: InstanceType) throws -> Callable {
        return try _bind(instance)
    }
}
