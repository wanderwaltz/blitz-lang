// MARK: - ASTInterpreter
final class ASTInterpreter {
    typealias Result = ASTInterpreterResult
    typealias ThrowableCommand = ASTInterpreterThrowableCommand
    typealias Environment = ASTInterpreterEnvironment

    weak var delegate: ASTInterpreterDelegate?

    let rootEnvironment = Environment()

    init() {
        environment = rootEnvironment
    }

    @discardableResult
    func execute(_ program: [Statement]) -> Result {
        let block = BlockStatement(statements: program)
        return executeBlock(block, environment: rootEnvironment)
    }

    func executeBlock(_ block: BlockStatement, environment: Environment) -> Result {
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
            case .throwable: result = r
            }
        }

        return result
    }

    private func evaluate(_ ast: ASTVisitable) throws -> Value {
        return try unwrap(ast.accept(self))
    }

    private typealias Depth = Int

    private var environment: Environment
    private var locals: [SourceLocation: Depth] = [:]
}




// MARK: - ASTVisitor
extension ASTInterpreter: ASTVisitor {
    typealias ReturnValue = Result

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> Result {
        return captureValue {
            var value = try evaluate(expression.value)

            if expression.op.type == .equal {
                return try setVariable(named: expression.identifier, value: value)
            }

            let existingValue = try lookupVariable(named: expression.identifier)
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

            return try setVariable(named: expression.identifier, value: value)
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

    func visitCallExpression(_ expression: CallExpression) -> Result {
        return captureValue {
            let location = expression.paren.location
            let callable = try lookupCallable(for: expression.callee, at: location)
            let arguments = try expression.arguments.map({ arg in
                try evaluate(arg)
            })

            do {
                return try callable.call(interpreter: self, arguments: arguments)
            }
            catch let internalError as InternalError {
                throw internalError.makeRuntimeError(location: location)
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

    func visitGetExpression(_ expression: GetExpression) -> Result {
        return captureValue {
            let object = expression.object
            let name = expression.name.lexeme
            let location = expression.name.location

            let gettable = try lookupGettable(for: object, at: location)

            do {
                return try gettable.getProperty(named: name)
            }
            catch let internalError as InternalError {
                throw internalError.makeRuntimeError(location: location)
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
            try lookupVariable(named: expression.identifier)
        }
    }

    func visitBlockStatement(_ statement: BlockStatement) -> Result {
        return executeBlock(statement, environment: Environment(parent: environment))
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> Result {
        return captureValue { try evaluate(statement.expression) }
    }

    func visitFunctionDeclarationStatement(_ statement: FunctionDeclarationStatement) -> Result {
        return captureValue {
            let function = Function(
                declaration: statement,
                closure: environment
            )

            let value: Value = .object(function)
            try environment.defineVariable(named: statement.name, value: value, isMutable: false)
            return value
        }
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

            guard let delegate = delegate else {
                throw RuntimeError(
                    code: .cannotPrint,
                    message: "cannot print '\(value)': interpeter delegate is not set",
                    location: statement.keyword.location
                )
            }

            delegate.interpreter(self, print: value)

            return .value(value)
        }
    }

    func visitReturnStatement(_ statement: ReturnStatement) -> Result {
        return captureResult {
            throw ThrowableCommand.return(try evaluate(statement.value))
        }
    }

    func visitSingleKeywordStatement(_ statement: SingleKeywordStatement) -> Result {
        return captureValue {
            switch statement.keyword.type {
            case .break:
                throw ThrowableCommand.break

            case .continue:
                throw ThrowableCommand.continue

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
                catch let command as ThrowableCommand {
                    switch command {
                    case .break:
                        breakFromLoop = true

                    case .continue:
                        continue

                    case .return:
                        throw command
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
        catch let command as ThrowableCommand {
            return .throwable(command)
        }
        catch let error {
            preconditionFailure("unexpected error received: \(error)")
        }
    }

    private func unwrap(_ result: Result) throws -> Value {
        switch result {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        case let .throwable(command): throw command
        }
    }
}



// MARK: - call support
extension ASTInterpreter {
    private func lookupCallable(for callee: Expression, at location: SourceLocation) throws -> Callable {
        let calleeValue = try evaluate(callee)

        switch calleeValue {
        case let .object(callable as Callable):
            return callable

        default:
            throw RuntimeError(
                code: .invalidCallee,
                message: "cannot call \(callee)",
                location: location
            )
        }
    }
}


// MARK: - getters support
extension ASTInterpreter {
    private func lookupGettable(for object: Expression, at location: SourceLocation) throws -> Gettable {
        let objectValue = try evaluate(object)

        switch objectValue {
        case let .string(string):
            guard let delegate = delegate else {
                throw RuntimeError(
                    code: .invalidGetExpression,
                    message: "cannot access properties of type '\(objectValue.typeName)': interpeter delegate is not set",
                    location: location
                )
            }

            return delegate.stringDelegateForInterpreter(self).bind(string)

        default:
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot access properties on object of type \(objectValue.typeName)",
                location: location
            )
        }
    }
}


// MARK: - resolver support
extension ASTInterpreter {
    func resolve(_ name: Token, depth: Int) {
        locals[name.location] = depth
    }

    private func lookupVariable(named name: Token) throws -> Value {
        if let depth = locals[name.location] {
            return try environment.get(at: depth, name)
        }
        else {
            return try rootEnvironment.get(name)
        }
    }

    private func setVariable(named name: Token, value: Value) throws -> Value {
        if let depth = locals[name.location] {
            return try environment.set(at: depth, name, value: value)
        }
        else {
            return try rootEnvironment.set(name, value: value)
        }
    }
}
