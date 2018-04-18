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

    private func parenthesize(_ args: Any...) -> String {
        let argDescriptions = args.map({ String(describing: $0) })
        let argsJoined = argDescriptions.joined(separator: " ")
        return ["〈", argsJoined, "〉"].joined(separator: "")
    }
}
