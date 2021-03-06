extension Value {
    var any: Any? {
        switch self {
        case .nil: return nil
        case let .bool(value): return value
        case let .number(value): return value
        case let .string(value): return value
        case let .array(values): return values
        case let .object(value):
            return value
        }
    }

    public init<T>(_ any: T) {
        if let convertible = any as? ConvertibleToBlitzValue {
            self = convertible.blitzValue
        }
        else {
            self = .object(any)
        }
    }
}
