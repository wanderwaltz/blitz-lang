struct Instantiator<_InstanceType> {
    typealias InstanceType = _InstanceType
    typealias Class = Volt.Class
    typealias Method = Class.Method

    init(initializer: Method, instantiate: @escaping (Class, Method, CallParameters) throws -> InstanceType) {
        self.initializer = initializer
        self.instantiate = instantiate
    }

    private let initializer: Method
    private let instantiate: (Class, Method, CallParameters) throws -> InstanceType
}


extension Instantiator {
    var validCallSignatures: [CallSignature] {
        return initializer.validBoundCallSignatures
    }

    func instantiate(klass: Class, with parameters: CallParameters) throws -> InstanceType {
        return try instantiate(klass, initializer, parameters)
    }
}
