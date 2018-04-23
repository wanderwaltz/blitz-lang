protocol ASTVisitable {
    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue
}

protocol ASTVisitor {
    associatedtype ReturnValue

    func visitLiteralExpression(_ expression: LiteralExpression) -> ReturnValue
    func visitBinaryExpression(_ expression: BinaryExpression) -> ReturnValue
    func visitGroupingExpression(_ expression: GroupingExpression) -> ReturnValue
}
