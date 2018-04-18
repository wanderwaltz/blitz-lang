struct BinaryExpression: Expression {
    let left: Expression
    let op: Token
    let right: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitBinaryExpression(self)
    }
}
