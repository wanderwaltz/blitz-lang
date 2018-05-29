struct ClassDeclarationStatement: Statement {
    let name: Token
    let initializer: FunctionDeclarationStatement
    let storedProperties: [VariableDeclarationStatement]
    let computedProperties: [ComputedPropertyDeclarationStatement]
    let methods: [FunctionDeclarationStatement]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitClassDeclarationStatement(self)
    }
}
