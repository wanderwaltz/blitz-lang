struct ArraySubscriptable {
    let signature = CallSignature(components: [nil])

    init(_ array: [Value]) {
        self.array = array
    }

    private let array: [Value]
}


extension ArraySubscriptable: Subscriptable {
    var validCallSignatures: [CallSignature] {
        return [signature]
    }

    func `subscript`(with parameters: SubscriptParameters) throws -> Value {
        guard parameters.signature == self.signature else {
            throw RuntimeError.invalidCallSignature(expected: self.signature, got: parameters.signature)
        }

        guard parameters.arguments.count == 1 else {
            throw RuntimeError.invalidNumberOfArguments(expected: 1, got: parameters.arguments.count)
        }

        let index = parameters.arguments[0]

        switch index {
        case let .number(value):
            let intIndex = Int(value)

            guard array.indices ~= intIndex else {
                throw RuntimeError.arrayIndex(intIndex, outOf: array.indices)
            }

            return array[intIndex]

        default:
            throw RuntimeError.typeError(expected: Int.self, got: index.typeName)
        }
    }
}
