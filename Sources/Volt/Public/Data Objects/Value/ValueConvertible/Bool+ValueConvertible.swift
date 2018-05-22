extension Bool: ValueConvertible {
    public var voltValue: Value {
        return .bool(self)
    }
}


extension Bool: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value.boolValue
    }
}
