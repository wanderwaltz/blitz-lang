struct CallExpression: Expression {
    let callee: Expression
    let paren: Token
    let arguments: [Expression]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitCallExpression(self)
    }
}
