struct ClassDeclarationStatement: Statement {
    let name: Token
    let methods: [FunctionDeclarationStatement]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitClassDeclarationStatement(self)
    }
}
