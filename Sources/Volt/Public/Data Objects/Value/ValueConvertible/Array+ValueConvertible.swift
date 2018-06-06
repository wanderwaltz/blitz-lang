extension Array: ConvertibleToVoltValue {
    public var voltValue: Value {
        return .array(self.map({ .init($0) }))
    }
}


extension Array: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .array(values):
            var result: [Element] = []

            for value in values {
                if let element = typecast<Element>.any(value.any) {
                    result.append(element)
                }
                else {
                    return nil
                }
            }

            return result

        default: return nil
        }
    }
}
