struct OverloadedCallable {
    var overloads: [CallSignature: Callable]

    init(overloads: [CallSignature: Callable]) {
        precondition(overloads.count > 0)
        self.overloads = overloads
    }
}


extension OverloadedCallable: Callable {
    var validCallSignatures: [CallSignature] {
        return Array(overloads.keys)
    }

    func call(with parameters: CallParameters) throws -> Value {
        guard let callable = overloads[parameters.signature] else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: parameters.signature)
        }

        return try callable.call(with: parameters)
    }
}
