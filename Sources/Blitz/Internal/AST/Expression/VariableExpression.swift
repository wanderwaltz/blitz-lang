struct VariableExpression: Expression {
    let identifier: Token

    var location: SourceLocation {
        return identifier.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitVariableExpression(self)
    }
}
