extension OverloadedCallable {
    init(_ callables: [Callable]) throws {
        var overloads: [CallSignature: Callable] = [:]

        for (signature, callable) in callables.map({ $0.unwrapped }).joined() {
            guard overloads[signature] == nil else {
                throw RuntimeError.overloadAlreadyExists(with: signature)
            }

            overloads[signature] = callable
        }

        self.init(overloads: overloads)
    }
}


private extension Callable {
    var unwrapped: [(CallSignature, Callable)] {
        guard let overloaded = self as? OverloadedCallable else {
            return validCallSignatures.map({ ($0, self) })
        }

        return Array(overloaded.overloads.map({ $0 }))
    }
}
