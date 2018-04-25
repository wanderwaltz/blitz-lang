struct PrintStatement: Statement {
    let expression: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitPrintStatement(self)
    }
}
