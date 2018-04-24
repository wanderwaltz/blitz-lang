struct AssignmentExpression: Expression {
    let identifier: Token
    let value: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitAssignmentExpression(self)
    }
}
