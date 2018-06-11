struct UnaryExpression: Expression {
    let op: Token
    let expression: Expression

    var location: SourceLocation {
        return op.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitUnaryExpression(self)
    }
}
