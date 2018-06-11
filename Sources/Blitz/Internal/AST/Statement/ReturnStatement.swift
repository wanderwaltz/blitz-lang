struct ReturnStatement: Statement {
    let keyword: Token
    let value: Expression?

    var location: SourceLocation {
        return value?.location ?? keyword.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitReturnStatement(self)
    }
}
