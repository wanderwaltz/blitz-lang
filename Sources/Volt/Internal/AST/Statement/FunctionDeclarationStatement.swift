struct FunctionDeclarationStatement: Statement {
    let name: Token
    let parameters: [Token]
    let body: BlockStatement

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitFunctionDeclarationStatement(self)
    }
}
