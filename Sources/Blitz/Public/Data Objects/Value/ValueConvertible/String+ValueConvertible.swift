extension String: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .string(self)
    }
}


extension String: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        return value.stringValue
    }
}
