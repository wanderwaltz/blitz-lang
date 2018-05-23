struct SetExpression: Expression {
    let object: Expression
    let name: Token
    let op: Token
    let value: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSetExpression(self)
    }
}
