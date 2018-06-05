struct AssignmentExpression: Expression {
    let identifier: Token
    let op: Token
    let value: Expression

    var location: SourceLocation {
        return op.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitAssignmentExpression(self)
    }
}
