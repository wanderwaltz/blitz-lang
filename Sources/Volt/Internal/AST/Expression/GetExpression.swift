struct GetExpression: Expression {
    let object: Expression
    let name: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitGetExpression(self)
    }
}
