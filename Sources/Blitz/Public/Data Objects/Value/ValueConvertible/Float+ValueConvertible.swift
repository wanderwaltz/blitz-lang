// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: - Float
extension Float: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Float: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Float(value)
        default: return typecast<Float>.any(value.any)
        }
    }
}


// MARK: - Double
extension Double: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Double: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Double(value)
        default: return typecast<Double>.any(value.any)
        }
    }
}


