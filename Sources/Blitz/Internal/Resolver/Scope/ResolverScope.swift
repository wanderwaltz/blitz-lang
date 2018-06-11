final class ResolverScope {
    typealias VariableStatus = ResolverScopeVariableStatus
    typealias ClassContext = ResolverScopeClassContext

    let type: ResolverScopeType
    var classContext: ResolverScopeClassContext = .none

    init(type: ResolverScopeType) {
        self.type = type
    }

    private(set) var defined: [String: VariableStatus] = [:]
}


extension ResolverScope {
    var allowsReturnStatement: Bool {
        return type.allowsReturnStatement
    }

    var allowsSelfExpression: Bool {
        return type.allowsSelfExpression
    }

    var allowsSuperExpression: Bool {
        return classContext == .subclass
    }
}


extension ResolverScope {
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
