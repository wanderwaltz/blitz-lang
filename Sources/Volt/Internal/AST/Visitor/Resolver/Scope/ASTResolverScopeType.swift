enum ASTResolverScopeType: Int {
case global
case `default`
case `class`
case function
case initializer
case method
}


extension ASTResolverScopeType {
    var allowsReturnStatement: Bool {
        switch self {
        case .function, .method, .initializer: return true
        case .global, .default, .class: return false
        }
    }

    var allowsSelfExpression: Bool {
        switch self {
        case .method, .initializer: return true
        case .global, .default, .class, .function: return false
        }
    }
}
