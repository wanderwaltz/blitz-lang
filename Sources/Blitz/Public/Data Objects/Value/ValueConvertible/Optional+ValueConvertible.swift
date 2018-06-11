extension Optional: ConvertibleToBlitzValue {
    public var blitzValue: Value {
        switch self {
        case .none: return .nil
        case let .some(value): return .init(value)
        }
    }
}


extension Optional: ConvertibleFromBlitzValue {
    public static func fromBlitzValue(_ value: Value) -> Any? {
        switch value {
        case .nil: return Optional<Wrapped>.none
        default:
            if let convertible = Wrapped.self as? ConvertibleFromBlitzValue.Type {
                return convertible.fromBlitzValue(value)
            }

            return value.any
        }
    }
}
