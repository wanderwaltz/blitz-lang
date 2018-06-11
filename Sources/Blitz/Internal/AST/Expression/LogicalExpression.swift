struct LogicalExpression: Expression {
    let left: Expression
    let op: Token
    let right: Expression

    var location: SourceLocation {
        return op.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitLogicalExpression(self)
    }
}
