struct GetExpression: Expression {
    let object: Expression
    let name: Token

    var location: SourceLocation {
        return name.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitGetExpression(self)
    }
}
