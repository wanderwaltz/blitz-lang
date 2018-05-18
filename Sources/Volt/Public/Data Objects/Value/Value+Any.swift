extension Value {
    var any: Any? {
        switch self {
        case .nil: return nil
        case let .bool(value): return value
        case let .number(value): return value
        case let .string(value): return value
        case let .object(value): return value
        }
    }

    public init<T>(_ any: T?) {
        guard let any = any else {
            self = .nil
            return
        }

        self.init(any)
    }

    public init<T>(_ any: T) {
        if let convertible = any as? ValueConvertible {
            self = convertible.voltValue
        }
        else {
            self = .object(any)
        }
    }
}
