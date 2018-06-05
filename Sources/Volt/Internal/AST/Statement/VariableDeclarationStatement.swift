struct VariableDeclarationStatement: Statement {
    let keyword: Token
    let identifier: Token
    let initializer: Expression

    var location: SourceLocation {
        return identifier.location
    }

    init(keyword: Token, identifier: Token, initializer: Expression) {
        precondition(keyword.type == .var || keyword.type == .let, "expected var or let keyword")
        self.keyword = keyword
        self.identifier = identifier
        self.initializer = initializer
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitVariableDeclarationStatement(self)
    }
}
