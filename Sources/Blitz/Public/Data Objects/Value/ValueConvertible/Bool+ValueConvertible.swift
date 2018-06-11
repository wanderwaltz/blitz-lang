extension Bool: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .bool(self)
    }
}


extension Bool: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        return value.boolValue
    }
}
