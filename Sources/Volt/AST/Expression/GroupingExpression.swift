struct GroupingExpression: Expression {
    let expression: Expression

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitGroupingExpression(self)
    }
}
