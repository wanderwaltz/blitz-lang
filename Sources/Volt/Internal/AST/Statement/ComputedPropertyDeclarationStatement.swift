struct ComputedPropertyDeclarationStatement: Statement {
    let name: Token
    let getter: BlockStatement
    let setter: BlockStatement?

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitComputedPropertyDeclarationStatement(self)
    }
}
