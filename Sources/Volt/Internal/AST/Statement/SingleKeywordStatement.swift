struct SingleKeywordStatement: Statement {
    let keyword: Token

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitSingleKeywordStatement(self)
    }
}
