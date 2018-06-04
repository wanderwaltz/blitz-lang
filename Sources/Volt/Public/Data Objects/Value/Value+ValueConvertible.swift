/// Conforming `Value` to `ValueConvertible` allows automatically unwrapping
/// `Values` contained in `Value.object` instances, which may occur when
/// interacting with native functions returning `Values`.
extension Value: ValueConvertible {
    public var voltValue: Value {
        switch self {
        case let .object(any):
            if let wrapped = any as? ValueConvertible {
                return wrapped.voltValue
            }
            fallthrough
        default:
            return self
        }
    }
}


extension Value: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        return value
    }
}
