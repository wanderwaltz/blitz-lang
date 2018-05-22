extension Float: ValueConvertible {
    public var voltValue: Value {
        return .number(Number(self))
    }
}


extension Float: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Float(value)
        default: return value.any as? Float
        }
    }
}
