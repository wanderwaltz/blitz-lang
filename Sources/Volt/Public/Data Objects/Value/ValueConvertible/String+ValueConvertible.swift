extension String: ConvertibleToVoltValue {
    public var voltValue: Value {
        return .string(self)
    }
}


extension String: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value.stringValue
    }
}
