struct ASTPrinter {
    func print(_ ast: ASTVisitable) -> String {
        return ast.accept(self)
    }
}


extension ASTPrinter: ASTVisitor {
    typealias ReturnValue = String

    func visitBinaryExpression(_ expression: BinaryExpression) -> String {
        return parenthesize(expression.left, expression.op, expression.right)
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> String {
        return String(describing: expression)
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> String {
        return parenthesize("(", print(expression.expression) ,")")
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
