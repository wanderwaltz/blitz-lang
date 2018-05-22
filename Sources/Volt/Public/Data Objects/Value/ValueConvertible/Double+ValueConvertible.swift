extension Double: ValueConvertible {
    public var voltValue: Value {
        return .number(Number(self))
    }
}


extension Double: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Double(value)
        default: return value.any as? Double
        }
    }
}
