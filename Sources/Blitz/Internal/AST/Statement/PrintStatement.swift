struct PrintStatement: Statement {
    let keyword: Token
    let expression: Expression

    var location: SourceLocation {
        return expression.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitPrintStatement(self)
    }
}
