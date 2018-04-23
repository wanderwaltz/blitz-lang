struct ASTInterpreter {
    func evaluate(_ ast: ASTVisitable) -> ASTInterpreterResult {
        return ast.accept(self)
    }
}


extension ASTInterpreter: ASTVisitor {
    typealias ReturnValue = ASTInterpreterResult

    func visitBinaryExpression(_ expression: BinaryExpression) -> ASTInterpreterResult {
        fatalError("not implemented")
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> ASTInterpreterResult {
        return .value(expression.literal.value)
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> ASTInterpreterResult {
        return evaluate(expression.expression)
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> ASTInterpreterResult {
        switch expression.op.type {
        case .minus:
            return evaluate(expression.expression).flatMap({ $0.numericNegated })

        case .bang, .not:
            return evaluate(expression.expression).flatMap({ $0.booleanNegated })

        default:
            preconditionFailure("unimplemented unary operator: \(expression.op)")
        }
    }
}
