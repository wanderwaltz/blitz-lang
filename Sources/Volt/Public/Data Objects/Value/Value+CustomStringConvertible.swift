extension Value: CustomStringConvertible {
    public var description: String {
        switch self {
        case .nil: return "nil"
        case let .bool(value): return String(describing: value)
        case let .number(value):
            let isInteger = value.truncatingRemainder(dividingBy: 1) == 0

            if isInteger {
                return String(describing: Int(value))
            }
            else {
                return String(describing: value)
            }

        case let .string(value): return String(describing: value)
        case let .array(values): return String(describing: values)
        case let .object(object): return String(describing: object)
        }
    }
}
