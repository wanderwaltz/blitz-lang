struct SuperExpression: Expression {
    let keyword: Token
    let name: Token

    var location: SourceLocation {
        return name.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSuperExpression(self)
    }
}
