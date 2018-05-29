struct ReadonlyComputedPropertyDeclarationStatement: Statement {
    let name: Token
    let getter: BlockStatement

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitReadonlyComputedPropertyDeclarationStatement(self)
    }
}
