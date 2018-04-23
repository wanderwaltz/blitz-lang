struct UnaryExpression: Expression {
    let op: Token
    let expression: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitUnaryExpression(self)
    }
}
