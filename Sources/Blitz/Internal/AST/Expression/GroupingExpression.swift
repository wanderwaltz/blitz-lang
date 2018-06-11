struct GroupingExpression: Expression {
    let expression: Expression

    var location: SourceLocation {
        return expression.location
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitGroupingExpression(self)
    }
}
