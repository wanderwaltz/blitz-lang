struct SuperSetExpression: Expression {
    let keyword: Token
    let name: Token
    let op: Token
    let value: Expression

    var location: SourceLocation {
        return op.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSuperSetExpression(self)
    }
}
