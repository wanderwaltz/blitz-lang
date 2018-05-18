final class ASTPrinter {
    func print(_ ast: [ASTVisitable]) -> String {
        return ast.map(print).joined(separator: "\n")
    }

    func print(_ ast: ASTVisitable) -> String {
        return ast.accept(self)
    }

    private var indentation = ""
}


extension ASTPrinter: ASTVisitor {
    typealias ReturnValue = String

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> String {
        return parenthesize(expression.identifier, expression.op, print(expression.value))
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> String {
        return parenthesize(expression.left, expression.op, expression.right)
    }

    func visitCallExpression(_ expression: CallExpression) -> String {
        let arguments = expression.arguments.map({ print($0) }).joined(separator: ", ")
        return parenthesize("call", print(expression.callee), "arguments: [", arguments, "]")
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> String {
        return parenthesize(String(describing: expression))
    }

    func visitLogicalExpression(_ expression: LogicalExpression) -> String {
        return parenthesize(expression.left, expression.op, expression.right)
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

    func visitBlockStatement(_ statement: BlockStatement) -> String {
        var components: [String] = ["{\n", indentedStatements(statement.statements), "\n}"]

        if !statement.atExit.isEmpty {
            components.append("atExit {\n")
            components.append(indentedStatements(statement.atExit))
            components.append("\n}")
        }

        return parenthesize(components.joined(separator: " "))
    }

    private func indentedStatements(_ statements: [Statement]) -> String {
        let printedStatements = statements.map({ print($0) }).joined(separator: "\n")
        let oldIndentation = indentation
        indentation += "    "
        let indentedStatements = indent(printedStatements)
        indentation = oldIndentation
        return indentedStatements
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> String {
        return print(statement.expression)
    }

    func visitFunctionDeclarationStatement(_ statement: FunctionDeclarationStatement) -> String {
        let components: [String] = [
            "func",
            statement.name.lexeme,
            "(",
            statement.parameters.map({ $0.lexeme }).joined(separator: ", "),
            ")",
            print(statement.body)
        ]

        return parenthesize(components.joined(separator: " "))
    }

    func visitIfStatement(_ statement: IfStatement) -> String {
        var components: [String] = ["if", print(statement.condition), print(statement.thenStatement)]

        if let elseStatement = statement.elseStatement {
            components.append("else")
            components.append(print(elseStatement))
        }

        return parenthesize(components.joined(separator: " "))
    }

    func visitImportStatement(_ statement: ImportStatement) -> String {
        return parenthesize("import", statement.identifier.lexeme)
    }

    func visitPrintStatement(_ statement: PrintStatement) -> String {
        return parenthesize("print", print(statement.expression))
    }

    func visitReturnStatement(_ statement: ReturnStatement) -> String {
        return parenthesize("return", print(statement.value))
    }

    func visitSingleKeywordStatement(_ statement: SingleKeywordStatement) -> String {
        return parenthesize(statement.keyword)
    }

    func visitVariableDeclarationStatement(_ statement: VariableDeclarationStatement) -> String {
        return parenthesize(statement.keyword, statement.identifier, "=", print(statement.initializer))
    }

    func visitWhileStatement(_ statement: WhileStatement) -> String {
        return parenthesize("while", print(statement.condition), print(statement.body))
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

    private func indent(_ string: String) -> String {
        let components = string.components(separatedBy: "\n")
        let indentedComponents = components.map({ indentation + $0 })
        return indentedComponents.joined(separator: "\n")
    }
}