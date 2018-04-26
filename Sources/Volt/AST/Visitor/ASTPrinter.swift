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
        return parenthesize(expression.identifier, "=", print(expression.value))
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> String {
        return parenthesize(expression.left, expression.op, expression.right)
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
        let statements = statement.statements.map({ print($0) }).joined(separator: "\n")
        let oldIndentation = indentation
        indentation += "    "
        let indentedStatements = indent(statements)
        indentation = oldIndentation
        return parenthesize("{\n", indentedStatements, "\n}")
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> String {
        return print(statement.expression)
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

    private func indent(_ string: String) -> String {
        let components = string.components(separatedBy: "\n")
        let indentedComponents = components.map({ indentation + $0 })
        return indentedComponents.joined(separator: "\n")
    }
}
