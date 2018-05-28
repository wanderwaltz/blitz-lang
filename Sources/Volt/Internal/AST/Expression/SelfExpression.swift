struct SelfExpression: Expression {
    let keyword: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSelfExpression(self)
    }
}
