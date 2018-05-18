enum ASTResolverScopeType: Int {
case global
case `default`
case function
}


extension ASTResolverScopeType {
    var allowsReturnStatement: Bool {
        switch self {
        case .global, .default: return false
        case .function: return true
        }
    }
}
