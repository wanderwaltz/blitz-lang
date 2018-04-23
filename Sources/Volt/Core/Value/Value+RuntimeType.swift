extension Value {
    var typeName: String {
        switch self {
        case .nil: return "nil"
        case .bool: return "Bool"
        case .number: return "Number"
        case .string: return "String"
        }
    }
}
