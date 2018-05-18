extension Value: Equatable {
    public static func == (left: Value, right: Value) -> Bool {
        switch (left, right) {
        case (.nil, .nil): return true
        case let (.bool(lb), .bool(rb)): return lb == rb
        case let (.number(ln), .number(rn)): return ln == rn
        case let (.string(ls), .string(rs)): return ls == rs
        default: return false
        }
    }
}
