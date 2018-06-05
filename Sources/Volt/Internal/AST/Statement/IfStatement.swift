struct IfStatement: Statement {
    let condition: Expression
    let thenStatement: Statement
    let elseStatement: Statement?
    let location: SourceLocation

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitIfStatement(self)
    }
}
