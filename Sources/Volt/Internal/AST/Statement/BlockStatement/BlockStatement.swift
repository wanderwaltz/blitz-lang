struct BlockStatement: Statement {
    let statements: [Statement]

    /// atExit statements are always executed prior exiting the scope
    /// even if a runtime error has occurred
    let atExit: [Statement]

    init(statements: [Statement], atExit: [Statement] = []) {
        self.statements = statements
        self.atExit = atExit
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitBlockStatement(self)
    }
}
