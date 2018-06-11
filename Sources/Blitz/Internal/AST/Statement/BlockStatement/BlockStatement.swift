struct BlockStatement: Statement {
    let statements: [Statement]

    /// atExit statements are always executed prior exiting the scope
    /// even if a runtime error has occurred
    let atExit: [Statement]

    let location: SourceLocation

    init(location: SourceLocation, statements: [Statement], atExit: [Statement] = []) {
        self.location = location
        self.statements = statements
        self.atExit = atExit
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitBlockStatement(self)
    }
}
