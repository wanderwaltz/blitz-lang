struct LiteralExpression: Expression {
    let literal: Literal

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitLiteralExpression(self)
    }
}
