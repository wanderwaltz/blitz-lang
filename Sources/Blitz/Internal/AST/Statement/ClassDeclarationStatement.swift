struct ClassDeclarationStatement: Statement {
    let name: Token
    let superclass: VariableExpression?
    let initializers: [FunctionDeclarationStatement]
    let storedProperties: [VariableDeclarationStatement]
    let computedProperties: [ComputedPropertyDeclarationStatement]
    let methods: [FunctionDeclarationStatement]

    var location: SourceLocation {
        return name.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitClassDeclarationStatement(self)
    }
}
