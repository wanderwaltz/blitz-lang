extension Value {
    var typeName: String {
        switch self {
        case .nil: return "nil"
        case .bool: return "Bool"
        case .number: return "Number"
        case .string: return "String"
        case let .object(object):
            if let custom = object as? CustomRuntimeTypeNameProviding {
                return custom.customRuntimeTypeName
            }

            return String(describing: type(of: object))
        }
    }
}
