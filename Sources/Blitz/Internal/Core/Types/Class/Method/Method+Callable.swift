extension Method: Callable {
    var validCallSignatures: [CallSignature] {
        return [unboundCallSignature]
    }

    func call(with parameters: CallParameters) throws -> Value {
        guard parameters.signature == unboundCallSignature else {
            throw RuntimeError.invalidCallSignature(expected: unboundCallSignature, got: parameters.signature)
        }

        guard parameters.arguments.count == 1 else {
            throw RuntimeError.invalidNumberOfArguments(expected: 1, got: parameters.arguments.count)
        }

        let arg = parameters.arguments[0]

        guard let instance = typecast<InstanceType>.any(arg.any) else {
            throw RuntimeError.typeError(expected: InstanceType.self, got: arg.typeName)
        }

        return .object(try bind(to: instance))
    }
}
