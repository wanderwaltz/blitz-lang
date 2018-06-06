// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: - Float
extension Float: ConvertibleToVoltValue {
    public var voltValue: Value {
        return .number(Number(self))
    }
}

extension Float: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Float(value)
        default: return typecast<Float>.any(value.any)
        }
    }
}


// MARK: - Double
extension Double: ConvertibleToVoltValue {
    public var voltValue: Value {
        return .number(Number(self))
    }
}

extension Double: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Double(value)
        default: return typecast<Double>.any(value.any)
        }
    }
}


