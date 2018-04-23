extension Value: CustomStringConvertible {
    var description: String {
        switch self {
        case .nil: return "nil"
        case let .bool(value): return String(describing: value)
        case let .number(value): return String(describing: value)
        case let .string(value): return String(describing: value)
        }
    }
}
