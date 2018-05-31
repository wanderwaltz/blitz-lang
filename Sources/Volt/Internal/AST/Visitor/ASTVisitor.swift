protocol ASTVisitable {
    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue
}

protocol ASTVisitor {
    associatedtype ReturnValue

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> ReturnValue
    func visitBinaryExpression(_ expression: BinaryExpression) -> ReturnValue
    func visitCallExpression(_ expression: CallExpression) -> ReturnValue
    func visitGetExpression(_ expression: GetExpression) -> ReturnValue
    func visitGroupingExpression(_ expression: GroupingExpression) -> ReturnValue
    func visitLiteralExpression(_ expression: LiteralExpression) -> ReturnValue
    func visitLogicalExpression(_ expression: LogicalExpression) -> ReturnValue
    func visitSelfExpression(_ expression: SelfExpression) -> ReturnValue
    func visitSetExpression(_ expression: SetExpression) -> ReturnValue
    func visitSuperExpression(_ expression: SuperExpression) -> ReturnValue
    func visitSuperSetExpression(_ expression: SuperSetExpression) -> ReturnValue
    func visitUnaryExpression(_ expression: UnaryExpression) -> ReturnValue
    func visitVariableExpression(_ expression: VariableExpression) -> ReturnValue

    func visitBlockStatement(_ statement: BlockStatement) -> ReturnValue
    func visitClassDeclarationStatement(_ statement: ClassDeclarationStatement) -> ReturnValue
    func visitComputedPropertyDeclarationStatement(_ statement: ComputedPropertyDeclarationStatement) -> ReturnValue
    func visitExpressionStatement(_ statement: ExpressionStatement) -> ReturnValue
    func visitFunctionDeclarationStatement(_ statement: FunctionDeclarationStatement) -> ReturnValue
    func visitIfStatement(_ statement: IfStatement) -> ReturnValue
    func visitImportStatement(_ statement: ImportStatement) -> ReturnValue
    func visitPrintStatement(_ statement: PrintStatement) -> ReturnValue
    func visitReturnStatement(_ statement: ReturnStatement) -> ReturnValue
    func visitSingleKeywordStatement(_ statement: SingleKeywordStatement) -> ReturnValue
    func visitVariableDeclarationStatement(_ statement: VariableDeclarationStatement) -> ReturnValue
    func visitWhileStatement(_ statement: WhileStatement) -> ReturnValue
}
