enum ASTResolverScopeType: Int {
case global
case `default`
case function
case method
}


extension ASTResolverScopeType {
    var allowsReturnStatement: Bool {
        switch self {
        case .global, .default: return false
        case .function, .method: return true
        }
    }
}
