enum ASTResolverScopeType: Int {
case global
case `default`
case `class`
case function
case method
}


extension ASTResolverScopeType {
    var allowsReturnStatement: Bool {
        switch self {
        case .global, .default, .class: return false
        case .function, .method: return true
        }
    }
}
