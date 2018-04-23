extension Literal: CustomStringConvertible {
    var description: String {
        switch self {
        case .nil: return "nil"
        case .true: return "true"
        case .false: return "false"
        case let .number(value): return String(describing: value)
        case let .string(value): return "\"\(value)\""
        }
    }
}
