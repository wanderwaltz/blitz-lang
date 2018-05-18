struct PrintStatement: Statement {
    let keyword: Token
    let expression: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitPrintStatement(self)
    }
}
