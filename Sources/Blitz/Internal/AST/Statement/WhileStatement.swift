struct WhileStatement: Statement {
    let condition: Expression
    let body: Statement

    var location: SourceLocation {
        return body.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitWhileStatement(self)
    }
}
