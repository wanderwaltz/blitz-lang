func overload<I>(_ methods: [Method<I>]) throws -> Method<I> {
    var signatures = Set<CallSignature>()

    for method in methods {
        for signature in method.validBoundCallSignatures {
            guard !signatures.contains(signature) else {
                throw RuntimeError.overloadAlreadyExists(with: signature)
            }

            signatures.insert(signature)
        }
    }

    return .init(
        validBoundCallSignatures: Array(signatures),
        bind: { instance in
            let callables = try methods.map({ try $0.bind(to: instance) })
            return try OverloadedCallable(callables)
        }
    )
}
