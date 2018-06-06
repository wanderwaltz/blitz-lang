extension Bool: ConvertibleToVoltValue {
    public var voltValue: Value {
        return .bool(self)
    }
}


extension Bool: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value.boolValue
    }
}
