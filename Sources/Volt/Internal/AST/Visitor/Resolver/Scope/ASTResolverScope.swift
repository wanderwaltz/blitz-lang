final class ASTResolverScope {
    typealias VariableStatus = ASTResolverScopeVariableStatus

    let type: ASTResolverScopeType

    init(type: ASTResolverScopeType) {
        self.type = type
    }

    private(set) var defined: [String: VariableStatus] = [:]
}


extension ASTResolverScope {
    func declare(_ name: Token) {
        defined[name.lexeme] = .declared
    }

    func define(_ name: String) {
        defined[name] = .defined
    }

    func define(_ name: Token) {
        define(name.lexeme)
    }

    func status(of name: Token) -> VariableStatus? {
        return defined[name.lexeme]
    }

    func knows(of name: Token) -> Bool {
        return status(of: name) != nil
    }
}
