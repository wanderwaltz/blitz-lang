extension ResolverResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .ok: return "ok"
        case let .error(error): return String(describing: error)
        }
    }
}
