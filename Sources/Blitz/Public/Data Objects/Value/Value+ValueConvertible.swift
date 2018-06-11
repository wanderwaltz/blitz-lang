/// Conforming `Value` to `ConvertibleToBlitzValue` allows automatically unwrapping
/// `Values` contained in `Value.object` instances, which may occur when
/// interacting with native functions returning `Values`.
extension Value: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        switch self {
        case let .object(any):
            if let wrapped = any as? ConvertibleToBlitzValue {
                return wrapped.blitzValue
            }
            fallthrough
        default:
            return self
        }
    }
}


extension Value: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        return value
    }
}
