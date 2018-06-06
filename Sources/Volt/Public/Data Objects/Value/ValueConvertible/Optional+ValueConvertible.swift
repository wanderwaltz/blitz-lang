extension Optional: ValueConvertible {
    public var voltValue: Value {
        switch self {
        case .none: return .nil
        case let .some(value): return .init(value)
        }
    }
}


extension Optional: ReverseValueConvertible {
    public static func fromVoltValue(_ value: Value) -> Any? {
        switch value {
        case .nil: return Optional<Wrapped>.none
        default:
            if let convertible = Wrapped.self as? ReverseValueConvertible.Type {
                return convertible.fromVoltValue(value)
            }

            return value.any
        }
    }
}
