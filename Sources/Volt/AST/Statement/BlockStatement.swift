struct BlockStatement: Statement {
    let statements: [Statement]

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitBlockStatement(self)
    }
}
