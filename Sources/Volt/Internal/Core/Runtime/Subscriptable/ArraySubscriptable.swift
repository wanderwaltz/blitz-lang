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

    func `subscript`(interpreter: Interpreter, signature: CallSignature, arguments: [Value]) throws -> Value {
        guard signature == self.signature else {
            throw RuntimeError.invalidCallSignature(expected: self.signature, got: signature)
        }

        guard arguments.count == 1 else {
            throw RuntimeError.invalidNumberOfArguments(expected: 1, got: arguments.count)
        }

        let index = arguments[0]

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
