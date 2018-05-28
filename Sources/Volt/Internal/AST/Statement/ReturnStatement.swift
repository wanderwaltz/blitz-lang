struct ReturnStatement: Statement {
    let keyword: Token
    let value: Expression?

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitReturnStatement(self)
    }
}
