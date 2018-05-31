struct SuperExpression: Expression {
    let keyword: Token
    let name: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSuperExpression(self)
    }
}
