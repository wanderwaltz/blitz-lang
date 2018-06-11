extension Array: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .array(self.map({ .init($0) }))
    }
}


extension Array: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
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
