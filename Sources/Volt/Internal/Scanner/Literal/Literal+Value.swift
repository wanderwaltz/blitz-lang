extension Literal {
    var value: Value {
        switch self {
        case .nil: return .nil
        case .true: return .bool(true)
        case .false: return .bool(false)
        case let .number(value): return .number(value)
        case let .string(value): return .string(value)
        }
    }
}
