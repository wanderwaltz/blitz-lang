struct CallExpression: Expression {
    typealias Argument = (label: Token?, value: Expression)

    let callee: Expression
    let paren: Token
    let arguments: [Argument]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitCallExpression(self)
    }
}
