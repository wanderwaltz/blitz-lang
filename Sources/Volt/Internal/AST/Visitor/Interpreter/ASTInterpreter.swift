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
            let object = try evaluate(expression.object)

            return try rawGet(
                propertyOf: object,
                named: expression.name
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
                let existingValue = try rawGet(propertyOf: object, named: name)
                value = try rawOpAssignment(existingValue: existingValue, op: expression.op, newValue: value)
            }

            return try rawSet(object: object, name: name, value: value)
        }
    }

    func visitSuperExpression(_ expression: SuperExpression) -> Result {
        return captureValue {
            let (superclass, this) = try lookupSuperSelf(keyword: expression.keyword)

            return try this.getProperty(
                named: expression.name.lexeme,
                inClass: superclass,
                interpreter: self
            )
        }
    }

    func visitSuperSetExpression(_ expression: SuperSetExpression) -> Result {
        return captureValue {
            var value = try evaluate(expression.value)
            let (superclass, this) = try lookupSuperSelf(keyword: expression.keyword)

            if expression.op.type != .equal {
                let existingValue = try this.getProperty(
                    named: expression.name.lexeme,
                    inClass: superclass,
                    interpreter: self
                )
                value = try rawOpAssignment(
                    existingValue: existingValue,
                    op: expression.op,
                    newValue: value
                )
            }

            try this.setProperty(
                named: expression.name.lexeme,
                value: value,
                inClass: superclass,
                interpreter: self
            )

            return value
        }
    }

    private func lookupSuperSelf(keyword: Token) throws -> (Class, Instance) {
        guard let depth = locals[keyword.location] else {
            preconditionFailure("super is not defined in current context")
        }

        guard let superclass = try environment.get(at: depth, keyword).any as? Class else {
            preconditionFailure("super is not defined at depth \(depth)")
        }

        let selfToken = Token(
            type: .self,
            lexeme: "self",
            location: keyword.location
        )

        // "this" is always one level nearer than "super"'s environment.
        guard let this = try environment.get(at: depth - 1, selfToken).any as? Instance else {
            preconditionFailure("self is not defined at depth \(depth - 1)")
        }

        return (superclass, this)
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
            var superclass: Class?

            if let superclassName = statement.superclass {
                let value = try lookupVariable(named: superclassName.identifier)

                guard case let .object(sc as Class) = value else {
                    throw RuntimeError(
                        code: .invalidSuperclass,
                        message: "inheritance from non-class type \(value.typeName)",
                        location: superclassName.identifier.location
                    )
                }

                superclass = sc

                environment = ASTInterpreterEnvironment(parent: environment)
                environment.forceDefineVariable(
                    named: .init(
                        type: .super,
                        lexeme: "super",
                        location: statement.name.location
                    ),
                    value: .object(sc),
                    isMutable: false
                )
            }

            let initializer = Function(
                declaration: statement.initializer,
                closure: environment
            )

            let storedProperties = Dictionary<String, StoredProperty>(
                uniqueKeysWithValues: try statement.storedProperties.map({ declaration in
                    let name = declaration.identifier.lexeme
                    let isMutable = declaration.keyword.type == .var
                    let value = try evaluate(declaration.initializer)

                    return (name, StoredProperty(
                        name: name,
                        isMutable: isMutable,
                        initialValue: value
                    ))
                })
            )

            let computedProperties = Dictionary<String, ComputedProperty>(
                uniqueKeysWithValues: statement.computedProperties.map({ declaration in
                    let name = declaration.name.lexeme

                    return (name, ComputedProperty(
                        name: name,
                        getter: Function(
                            declaration: .init(
                                name: declaration.name,
                                parameters: [],
                                body: declaration.getter
                            ),
                            closure: environment
                        ),
                        setter: declaration.setter.map({ setter in
                            Function(
                                declaration: .init(
                                    name: declaration.name,
                                    parameters: [
                                        (
                                            label: .init(
                                                type: .identifier,
                                                lexeme: "_",
                                                location: declaration.name.location
                                            ),
                                            name: .newValue(at: declaration.name.location)
                                        )
                                    ],
                                    body: setter
                                ),
                                closure: environment
                            )
                        })
                    ))
                })
            )

            let methods = Dictionary<String, Function>(
                uniqueKeysWithValues: statement.methods.map({ declaration in
                    (declaration.name.lexeme, Function(declaration: declaration, closure: environment))
                })
            )

            let klass = Class(
                name: statement.name.lexeme,
                superclass: superclass,
                initializer: initializer,
                storedProperties: storedProperties,
                computedProperties: computedProperties,
                methods: methods
            )

            if superclass != nil {
                guard let parentEnvironment = environment.parent else {
                    preconditionFailure("should have created an environment for `super`")
                }

                environment = parentEnvironment
            }

            let value = Value.object(klass)
            try environment.defineVariable(named: statement.name, value: value, isMutable: false)
            return value
        }
    }

    func visitComputedPropertyDeclarationStatement(_ statement: ComputedPropertyDeclarationStatement) -> Result {
        preconditionFailure("visiting computed property declarations is not supported")
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
                    message: "cannot import module '\(moduleName)': interpreter delegate is not set",
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

            var valueToPrint = value

            if case let .object(convertible as VoltStringConvertible) = value {
                do {
                    let string = try convertible.voltDescription(interpreter: self)
                    valueToPrint = string.map({ Value.string($0) }) ?? valueToPrint
                }
                catch let internalError as InternalError {
                    throw internalError.makeRuntimeError(location: statement.keyword.location)
                }
            }

            delegate.interpreter(self, print: valueToPrint)

            return .value(value)
        }
    }

    func visitReturnStatement(_ statement: ReturnStatement) -> Result {
        return captureResult {
            let value = try statement.value.map({ try evaluate($0) }) ?? .nil
            throw ThrowableCommand.return(value)
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

    private func rawSet(object: Value, name: Token, value: Value) throws -> Value {
        let location = name.location
        let settable = try lookupSettable(for: object, at: location)

        do {
            try settable.setProperty(named: name.lexeme, value: value, interpreter: self)
            return value
        }
        catch let internalError as InternalError {
            throw internalError.makeRuntimeError(location: location)
        }
    }

    private func lookupSettable(for object: Value, at location: SourceLocation) throws -> Settable {
        if case let .object(settable as Settable) = object {
            return settable
        }

        guard let delegate = delegate else {
            throw RuntimeError(
                code: .invalidSetExpression,
                message: "cannot write properties of type '\(object.typeName)': interpreter delegate is not set",
                location: location
            )
        }

        guard let settable = delegate.interpreter(self, settableFor: object) else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot write properties on object of type \(object.typeName)",
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
