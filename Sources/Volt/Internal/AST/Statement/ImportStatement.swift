struct ImportStatement: Statement {
    let identifier: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitImportStatement(self)
    }
}
