struct WhileStatement: Statement {
    let condition: Expression
    let body: Statement

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitWhileStatement(self)
    }
}
