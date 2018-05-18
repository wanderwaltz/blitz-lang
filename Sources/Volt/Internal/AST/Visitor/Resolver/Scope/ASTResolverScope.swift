final class ASTResolverScope {
    typealias VariableStatus = ASTResolverScopeVariableStatus

    private(set) var defined: [String: VariableStatus] = [:]
}


extension ASTResolverScope {
    func declare(_ name: Token) {
        defined[name.lexeme] = .declared
    }

    func define(_ name: Token) {
        defined[name.lexeme] = .defined
    }

    func status(of name: Token) -> VariableStatus? {
        return defined[name.lexeme]
    }

    func knows(of name: Token) -> Bool {
        return status(of: name) != nil
    }
}
