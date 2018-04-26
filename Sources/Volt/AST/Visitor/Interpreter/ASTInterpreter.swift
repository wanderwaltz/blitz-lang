// MARK: - ASTInterpreter
final class ASTInterpreter {
    typealias Result = ASTInterpreterResult
    typealias RuntimeError = ASTIntepreterRuntimeError
    typealias Environment = ASTInterpreterEnvironment

    init() {
        environment = rootEnvironment
    }

    @discardableResult
    func execute(_ program: [Statement]) -> Result {
        return executeBlock(program, environment: rootEnvironment)
    }

    private func executeBlock(_ statements: [Statement], environment: Environment) -> Result {
        let previousEnvironment = self.environment
        defer {
            self.environment = previousEnvironment
        }

        self.environment = environment

        var result: Result = .value(.nil)

        for statement in statements {
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

    private let rootEnvironment = Environment()
    private var environment: Environment
}




// MARK: - ASTVisitor
extension ASTInterpreter: ASTVisitor {
    typealias ReturnValue = Result

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> Result {
        return captureValue {
            let value = try evaluate(expression.value)

            return try environment.set(expression.identifier, value: value)
        }
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> Result {
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

    func visitLiteralExpression(_ expression: LiteralExpression) -> Result {
        return captureValue { expression.literal.value }
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> Result {
        return captureValue { try evaluate(expression.expression) }
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> Result {
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

    func visitVariableExpression(_ expression: VariableExpression) -> Result {
        return captureValue {
            try environment.get(expression.identifier)
        }
    }

    func visitBlockStatement(_ statement: BlockStatement) -> Result {
        return executeBlock(statement.statements, environment: Environment(parent: environment))
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> Result {
        return captureValue { try evaluate(statement.expression) }
    }

    func visitPrintStatement(_ statement: PrintStatement) -> Result {
        return captureResult {
            let value = try evaluate(statement.expression)
            print(value)
            return .value(value)
        }
    }

    func visitVariableDeclarationStatement(_ statement: VariableDeclarationStatement) -> Result {
        return captureValue {
            let value = try evaluate(statement.initializer)

            try environment.defineVariable(
                named: statement.identifier,
                value: value,
                isMutable: statement.keyword.type == .var
            )

            return value
        }
    }
}




// MARK: - utility methods
extension ASTInterpreter {
    private func captureValue(of block: () throws -> Value) -> Result {
        return captureResult(of: { .value(try block()) })
    }

    private func captureResult(of block: () throws -> Result) -> Result {
        do {
            return try block()
        }
        catch let error as RuntimeError {
            return .runtimeError(error)
        }
        catch let error {
            preconditionFailure("unexpected error received: \(error)")
        }
    }

    private func unwrap(_ result: Result) throws -> Value {
        switch result {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        }
    }
}