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

    func call(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard let callable = overloads[signature] else {
            throw RuntimeError.invalidCallSignature(expected: validCallSignatures, got: signature)
        }

        return try callable.call(
            interpreter: interpreter,
            signature: signature,
            arguments: arguments
        )
    }
}
