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

            if expression.op.type != .equal {
                let existingValue = try lookupVariable(named: expression.identifier)
                value = try rawOpAssignment(existingValue: existingValue, op: expression.op, newValue: value)
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
                try evaluate(arg.value)
            })

            do {
                return try callable.call(
                    interpreter: self,
                    signature: expression.signature,
                    arguments: arguments
                )
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
            return try rawGet(
                object: try evaluate(expression.object),
                name: expression.name
            )
        }
    }

    func visitSelfExpression(_ expression: SelfExpression) -> Result {
        return captureValue {
            return try lookupVariable(named: expression.keyword)
        }
    }

    func visitSetExpression(_ expression: SetExpression) -> Result {
        return captureValue {
            let object = try evaluate(expression.object)
            let name = expression.name

            var value = try evaluate(expression.value)

            if expression.op.type != .equal {
                let existingValue = try rawGet(object: object, name: name)
                value = try rawOpAssignment(existingValue: existingValue, op: expression.op, newValue: value)
            }

            return try rawSet(object: object, name: name, value: value)
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

    func visitClassDeclarationStatement(_ statement: ClassDeclarationStatement) -> Result {
        return captureValue {
            let methods = Dictionary<String, Function>(
                uniqueKeysWithValues: statement.methods.map({ declaration in
                    (declaration.name.lexeme, Function(declaration: declaration, closure: environment))
                })
            )

            let klass = Class(
                name: statement.name.lexeme,
                methods: methods,
                initializer: Function(
                    declaration: statement.initializer,
                    closure: environment
                )
            )

            let value = Value.object(klass)
            try environment.defineVariable(named: statement.name, value: value, isMutable: false)
            return value
        }
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


// MARK: - getters/setters support
extension ASTInterpreter {
    private func rawOpAssignment(existingValue: Value, op: Token, newValue: Value) throws -> Value {
        let location = op.location

        switch op.type {
        case .minusEqual:
            return try unwrap(existingValue.subtracting(newValue, at: location))

        case .plusEqual:
            return try unwrap(existingValue.adding(newValue, at: location))

        case .slashEqual:
            return try unwrap(existingValue.dividing(by: newValue, at: location))

        case .starEqual:
            return try unwrap(existingValue.multiplying(by: newValue, at: location))

        default:
            preconditionFailure("unimplemented assignment operator \(op)")
        }
    }

    private func rawGet(object: Value, name: Token) throws -> Value {
        let location = name.location

        let gettable = try lookupGettable(for: object, at: location)

        do {
            return try gettable.getProperty(named: name.lexeme)
        }
        catch let internalError as InternalError {
            throw internalError.makeRuntimeError(location: location)
        }
    }

    private func rawSet(object: Value, name: Token, value: Value) throws -> Value {
        let location = name.location
        let settable = try lookupSettable(for: object, at: location)

        do {
            try settable.setProperty(named: name.lexeme, value: value)
            return value
        }
        catch let internalError as InternalError {
            throw internalError.makeRuntimeError(location: location)
        }
    }

    private func lookupGettable(for object: Value, at location: SourceLocation) throws -> Gettable {
        if case let .object(gettable as Gettable) = object {
            return gettable
        }

        guard let delegate = delegate else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot access properties of type '\(object.typeName)': interpeter delegate is not set",
                location: location
            )
        }

        guard let gettable = delegate.interpreter(self, gettableFor: object) else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot access properties on object of type \(object.typeName)",
                location: location
            )
        }

        return gettable
    }

    private func lookupSettable(for object: Value, at location: SourceLocation) throws -> Settable {
        guard let delegate = delegate else {
            throw RuntimeError(
                code: .invalidSetExpression,
                message: "cannot access properties of type '\(object.typeName)': interpeter delegate is not set",
                location: location
            )
        }

        guard let settable = delegate.interpreter(self, settableFor: object) else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot access properties on object of type \(object.typeName)",
                location: location
            )
        }

        return settable
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
