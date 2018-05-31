struct SuperSetExpression: Expression {
    let keyword: Token
    let name: Token
    let op: Token
    let value: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSuperSetExpression(self)
    }
}
