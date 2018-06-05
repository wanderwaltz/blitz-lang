struct ExpressionStatement: Statement {
    let expression: Expression

    var location: SourceLocation {
        return expression.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitExpressionStatement(self)
    }
}
