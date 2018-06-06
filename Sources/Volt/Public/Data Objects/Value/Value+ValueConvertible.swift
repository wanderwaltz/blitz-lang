/// Conforming `Value` to `ConvertibleToVoltValue` allows automatically unwrapping
/// `Values` contained in `Value.object` instances, which may occur when
/// interacting with native functions returning `Values`.
extension Value: ConvertibleToVoltValue {
    public var voltValue: Value {
        switch self {
        case let .object(any):
            if let wrapped = any as? ConvertibleToVoltValue {
                return wrapped.voltValue
            }
            fallthrough
        default:
            return self
        }
    }
}


extension Value: ConvertibleFromVoltValue {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value
    }
}
