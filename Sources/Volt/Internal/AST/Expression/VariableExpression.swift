struct VariableExpression: Expression {
    let identifier: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitVariableExpression(self)
    }
}
