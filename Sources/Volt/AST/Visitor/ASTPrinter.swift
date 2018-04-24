struct ASTPrinter {
    func print(_ ast: [ASTVisitable]) -> String {
        return ast.map(print).joined(separator: "\n")
    }

    func print(_ ast: ASTVisitable) -> String {
        return ast.accept(self)
    }
}


extension ASTPrinter: ASTVisitor {
    typealias ReturnValue = String

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> String {
        return parenthesize(expression.identifier, "=", print(expression.value))
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> String {
        return parenthesize(expression.left, expression.op, expression.right)
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> String {
        return parenthesize(String(describing: expression))
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> String {
        return parenthesize("(", print(expression.expression) ,")")
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> String {
        return parenthesize(expression.op, expression.expression)
    }

    func visitVariableExpression(_ expression: VariableExpression) -> String {
        return parenthesize(expression.identifier.lexeme)
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> String {
        return print(statement.expression)
    }

    func visitVariableDeclarationStatement(_ statement: VariableDeclarationStatement) -> String {
        return parenthesize(statement.keyword, statement.identifier, "=", print(statement.initializer))
    }

    private func parenthesize(_ args: Any...) -> String {
        let argDescriptions = args.map({ arg -> String in
            if let visitable = arg as? ASTVisitable {
                return print(visitable)
            }
            else {
                return String(describing: arg)
            }
        })

        let argsJoined = argDescriptions.joined(separator: " ")

        return ["〈", argsJoined, "〉"].joined(separator: "")
    }
}
