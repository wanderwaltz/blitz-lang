// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: - Int8
extension Int8: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Int8: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int8(value)
        default: return typecast<Int8>.any(value.any)
        }
    }
}


// MARK: - Int16
extension Int16: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Int16: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int16(value)
        default: return typecast<Int16>.any(value.any)
        }
    }
}


// MARK: - Int32
extension Int32: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Int32: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int32(value)
        default: return typecast<Int32>.any(value.any)
        }
    }
}


// MARK: - Int64
extension Int64: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Int64: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int64(value)
        default: return typecast<Int64>.any(value.any)
        }
    }
}


// MARK: - Int
extension Int: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension Int: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return Int(value)
        default: return typecast<Int>.any(value.any)
        }
    }
}


// MARK: - UInt
extension UInt: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension UInt: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return UInt(value)
        default: return typecast<UInt>.any(value.any)
        }
    }
}


// MARK: - UInt8
extension UInt8: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension UInt8: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return UInt8(value)
        default: return typecast<UInt8>.any(value.any)
        }
    }
}


// MARK: - UInt16
extension UInt16: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension UInt16: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return UInt16(value)
        default: return typecast<UInt16>.any(value.any)
        }
    }
}


// MARK: - UInt32
extension UInt32: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension UInt32: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return UInt32(value)
        default: return typecast<UInt32>.any(value.any)
        }
    }
}


// MARK: - UInt64
extension UInt64: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        return .number(Number(self))
    }
}

extension UInt64: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case let .number(value): return UInt64(value)
        default: return typecast<UInt64>.any(value.any)
        }
    }
}


