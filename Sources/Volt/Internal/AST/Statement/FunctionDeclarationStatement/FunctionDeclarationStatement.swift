struct FunctionDeclarationStatement: Statement {
    typealias ParamDecl = (label: Token, name: Token)

    let name: Token
    let parameters: [ParamDecl]
    let body: BlockStatement

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitFunctionDeclarationStatement(self)
    }
}
