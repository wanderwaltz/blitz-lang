struct ArrayLiteralExpression: Expression {
    let location: SourceLocation
    let elements: [Expression]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitArrayLiteralExpression(self)
    }
}
