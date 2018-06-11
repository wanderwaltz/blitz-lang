/// An abstraction, which is used to instantiate a given class
/// conforming to Instantiatable protocol.
struct Instantiator<_Class: Instantiatable> {
    typealias Class = _Class
    typealias InstanceType = Class.InstanceType
    typealias Method = Blitz.Method<InstanceType>

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
