struct ImportStatement: Statement {
    let identifier: Token

    var location: SourceLocation {
        return identifier.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitImportStatement(self)
    }
}
