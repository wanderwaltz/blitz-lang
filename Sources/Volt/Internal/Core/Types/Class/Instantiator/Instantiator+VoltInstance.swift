extension Instantiator where _Class == Class {
    /// A convenience initializer for instantiating Volt class instances.
    /// - Parameter initializer: an initializer method which is called
    ///                          after instantiating a Volt Instance.
    ///                          Can be overloaded.
    init(_ initializer: Method) {
        self.init(
            initializer: initializer,
            instantiate: { klass, initializer, parameters in
                let validSignatures = initializer.validBoundCallSignatures

                guard validSignatures.contains(parameters.signature) else {
                    throw RuntimeError.invalidCallSignature(expected: validSignatures, got: parameters.signature)
                }

                let instance = Instance(klass: klass)

                _ = try initializer
                    .bind(to: instance)
                    .call(with: parameters)

                return instance
            }
        )
    }
}
