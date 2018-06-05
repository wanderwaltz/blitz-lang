struct LiteralExpression: Expression {
    let literal: Literal
    let location: SourceLocation

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitLiteralExpression(self)
    }
}
