// MARK: - ASTInterpreter
final class ASTInterpreter {
    typealias Result = ASTInterpreterResult
    typealias RuntimeError = ASTIntepreterRuntimeError
    typealias Environment = ASTInterpreterEnvironment

    weak var delegate: ASTInterpreterDelegate?

    init() {
        environment = rootEnvironment
    }

    @discardableResult
    func execute(_ program: [Statement]) -> Result {
        let block = BlockStatement(statements: program)
        return executeBlock(block, environment: rootEnvironment)
    }

    private func executeBlock(_ block: BlockStatement, environment: Environment) -> Result {
        let previousEnvironment = self.environment
        defer {
            self.environment = previousEnvironment
        }

        self.environment = environment

        var result: Result = .value(.nil)

        for statement in block.statements {
            result = result.flatMap({ _ in statement.accept(self) })

            if case .runtimeError = result {
                break
            }
        }

        // atExit statements are executed even in case of error
        for statement in block.atExit {
            let r = statement.accept(self)

            switch r {
            case .value: break
            case .runtimeError: result = r
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
            var value = try evaluate(expression.value)

            if expression.op.type == .equal {
                return try environment.set(expression.identifier, value: value)
            }

            let existingValue = try environment.get(expression.identifier)
            let location = expression.op.location

            switch expression.op.type {
            case .minusEqual:
                value = try unwrap(existingValue.subtracting(value, at: location))

            case .plusEqual:
                value = try unwrap(existingValue.adding(value, at: location))

            case .slashEqual:
                value = try unwrap(existingValue.dividing(by: value, at: location))

            case .starEqual:
                value = try unwrap(existingValue.multiplying(by: value, at: location))

            default:
                preconditionFailure("unimplemented assignment operator \(expression.op)")
            }

            return try environment.set(expression.identifier, value: value)
        }
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> Result {
        return captureResult {
            let left = try evaluate(expression.left)
            let right = try evaluate(expression.right)
            let location = expression.op.location

            switch expression.op.type {
            case .plus:
                return left.adding(right, at: location)

            case .minus:
                return left.subtracting(right, at: location)

            case .star:
                return left.multiplying(by: right, at: location)

            case .slash:
                return left.dividing(by: right, at: location)

            case .greater:
                return left.isGreater(than: right, at: location)

            case .greaterEqual:
                return left.isNotLess(than: right, at: location)

            case .less:
                return left.isLess(than: right, at: location)

            case .lessEqual:
                return left.isNotGreater(than: right, at: location)

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

    func visitLogicalExpression(_ expression: LogicalExpression) -> Result {
        return captureValue {
            let left = try evaluate(expression.left)

            switch expression.op.type {
            case .or:
                if left.boolValue {
                    return .bool(true)
                }
                else {
                    return .bool(try evaluate(expression.right).boolValue)
                }

            case .and:
                if !left.boolValue {
                    return .bool(false)
                }
                else {
                    return .bool(try evaluate(expression.right).boolValue)
                }

            case .questionQuestion:
                if left.boolValue {
                    return left
                }
                else {
                    return try evaluate(expression.right)
                }

            default:
                preconditionFailure("unimplemented logical operator: \(expression.op)")
            }
        }
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> Result {
        return captureValue { try evaluate(expression.expression) }
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> Result {
        return captureResult {
            let value = try evaluate(expression.expression)
            let location = expression.op.location

            switch expression.op.type {
            case .minus:
                return value.arithmeticalNegated(at: location)

            case .bang, .not:
                return value.logicalNegated

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
        return executeBlock(statement, environment: Environment(parent: environment))
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> Result {
        return captureValue { try evaluate(statement.expression) }
    }

    func visitIfStatement(_ statement: IfStatement) -> Result {
        return captureValue {
            var result: Value = .nil

            let condition = try evaluate(statement.condition)

            if condition.boolValue {
                result = try evaluate(statement.thenStatement)
            }
            else if let elseStatement = statement.elseStatement {
                result = try evaluate(elseStatement)
            }

            return result
        }
    }

    func visitImportStatement(_ statement: ImportStatement) -> Result {
        return captureValue {
            let moduleName = statement.identifier.lexeme

            guard let delegate = delegate else {
                throw RuntimeError(
                    code: .cannotImportModule,
                    message: "cannot import module '\(moduleName)': interpeter delegate is not set",
                    location: statement.identifier.location
                )
            }

            switch try delegate.interpreter(self, importModuleNamed: moduleName) {
            case let .new(program):
                return try unwrap(execute(program.statements))

            case .alreadyImported: // modules are imported only once
                break
            }

            return .nil
        }
    }

    func visitPrintStatement(_ statement: PrintStatement) -> Result {
        return captureResult {
            let value = try evaluate(statement.expression)
            print(value)
            return .value(value)
        }
    }

    func visitSingleKeywordStatement(_ statement: SingleKeywordStatement) -> Result {
        let location = statement.keyword.location

        return captureValue {
            switch statement.keyword.type {
            case .break:
                throw ASTIntepreterRuntimeError(code: .break, message: "", location: location)

            case .continue:
                throw ASTIntepreterRuntimeError(code: .continue, message: "", location: location)

            default:
                preconditionFailure("unimplemented \(statement.keyword) statement")
            }
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

    func visitWhileStatement(_ statement: WhileStatement) -> Result {
        return captureValue {
            var value: Value = .nil

            var condition = try evaluate(statement.condition)
            var breakFromLoop = false

            while condition.boolValue {
                do {
                    value = try evaluate(statement.body)
                }
                catch let error as RuntimeError {
                    switch error.code {
                    case .break:
                        breakFromLoop = true

                    case .continue:
                        continue

                    default:
                        throw error
                    }
                }
                catch let error {
                    throw error
                }

                if breakFromLoop {
                    break
                }

                condition = try evaluate(statement.condition)
            }

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
