extension Int: ValueConvertible {
    public var voltValue: Value {
        return .number(Number(self))
    }
}


extension Int: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int(value)
        default: return value.any as? Int
        }
    }
}
