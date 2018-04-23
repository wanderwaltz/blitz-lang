struct ASTInterpreter {
    func evaluate(_ ast: ASTVisitable) -> ASTInterpreterResult {
        return ast.accept(self)
    }
}


extension ASTInterpreter: ASTVisitor {
    typealias ReturnValue = ASTInterpreterResult

    func visitBinaryExpression(_ expression: BinaryExpression) -> ASTInterpreterResult {
        return evaluate(expression.left).flatMap({ left in
            evaluate(expression.right).flatMap({ right in
                switch expression.op.type {
                case .plus:
                    return left + right

                case .minus:
                    return left - right

                case .star:
                    return left * right

                case .slash:
                    return left / right

                case .greater:
                    return left > right

                case .greaterEqual:
                    return left >= right

                case .less:
                    return left < right

                case .lessEqual:
                    return left <= right

                case .equalEqual:
                    return .value(.bool(left == right))

                case .bangEqual:
                    return .value(.bool(left != right))

                default:
                    preconditionFailure("unimplemented binary operator: \(expression.op)")
                }
            })
        })
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> ASTInterpreterResult {
        return .value(expression.literal.value)
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> ASTInterpreterResult {
        return evaluate(expression.expression)
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> ASTInterpreterResult {
        return evaluate(expression.expression).flatMap({ value in
            switch expression.op.type {
            case .minus:
                return -value

            case .bang, .not:
                return !value

            default:
                preconditionFailure("unimplemented unary operator: \(expression.op)")
            }
        })
    }
}
