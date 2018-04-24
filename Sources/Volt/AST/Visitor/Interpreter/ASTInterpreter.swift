struct ASTInterpreter {
    func execute(_ program: [Statement]) -> ASTInterpreterResult {
        var result: ASTInterpreterResult = .value(.nil)

        for statement in program {
            result = result.flatMap({ _ in statement.accept(self) })

            if case .runtimeError = result {
                break
            }
        }

        return result
    }

    private func evaluate(_ ast: ASTVisitable) throws -> Value {
        return try unwrap(ast.accept(self))
    }
}


extension ASTInterpreter: ASTVisitor {
    typealias ReturnValue = ASTInterpreterResult

    func visitBinaryExpression(_ expression: BinaryExpression) -> ASTInterpreterResult {
        return captureResult {
            let left = try evaluate(expression.left)
            let right = try evaluate(expression.right)

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
        }
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> ASTInterpreterResult {
        return captureValue { expression.literal.value }
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> ASTInterpreterResult {
        return captureValue { try evaluate(expression.expression) }
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> ASTInterpreterResult {
        return captureResult {
            let value = try evaluate(expression.expression)

            switch expression.op.type {
            case .minus:
                return -value

            case .bang, .not:
                return !value

            default:
                preconditionFailure("unimplemented unary operator: \(expression.op)")
            }
        }
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> ASTInterpreterResult {
        return captureValue { try evaluate(statement.expression) }
    }

    func visitVarDeclarationStatement(_ statement: VarDeclarationStatement) -> ASTInterpreterResult {
        return captureValue {
            // TODO: actually declare the var
            try evaluate(statement.initializer)
        }
    }

    private func captureValue(of block: () throws -> Value) -> ASTInterpreterResult {
        return captureResult(of: { .value(try block()) })
    }

    private func captureResult(of block: () throws -> ASTInterpreterResult) -> ASTInterpreterResult {
        do {
            return try block()
        }
        catch let error as ASTIntepreterRuntimeError {
            return .runtimeError(error)
        }
        catch let error {
            preconditionFailure("unexpected error received: \(error)")
        }
    }

    private func unwrap(_ result: ASTInterpreterResult) throws -> Value {
        switch result {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        }
    }
}
