struct ComputedPropertyDeclarationStatement: Statement {
    let name: Token
    let getter: BlockStatement
    let setter: BlockStatement?

    var location: SourceLocation {
        return name.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitComputedPropertyDeclarationStatement(self)
    }
}
