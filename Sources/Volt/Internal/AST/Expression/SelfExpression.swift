struct SelfExpression: Expression {
    let keyword: Token

    var location: SourceLocation {
        return keyword.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSelfExpression(self)
    }
}
