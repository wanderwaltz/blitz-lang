extension String: ValueConvertible {
    public var voltValue: Value {
        return .string(self)
    }
}


extension String: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value.stringValue
    }
}
