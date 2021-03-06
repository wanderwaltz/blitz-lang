// MARK: - Resolver
final class Resolver {
    typealias Result = ResolverResult
    typealias Scope = ResolverScope
    typealias ScopeType = ResolverScopeType

    init(interpreter: Interpreter) {
        self.interpreter = interpreter
    }

    private let interpreter: Interpreter
    private var scopes: [Scope] = [.init(type: .global)]
}


// MARK: - utility methods
extension Resolver {
    func resolve(_ statements: [Statement]) throws {
        for statement in statements {
            try resolve(statement)
        }
    }

    func resolve(_ statement: Statement) throws {
        try unwrap { statement.accept(self) }
    }

    func resolve(_ expression: Expression) throws {
        try unwrap { expression.accept(self) }
    }
}


// MARK: - result/throw conversion
extension Resolver {
    private func captureResult(_ block: () throws -> Void) -> Result {
        do {
            try block()
            return .ok
        }
        catch let error as ResolverError {
            return .error(error)
        }
        catch let error {
            preconditionFailure("unexpected error: \(error)")
        }
    }

    private func unwrap(_ block: () -> Result) throws {
        switch block() {
        case .ok: break
        case let .error(error): throw error
        }
    }
}


// MARK: - working with sopes
extension Resolver {
    private func beginScope(type: ScopeType) {
        scopes.append(.init(type: type))
    }

    private func endScope() {
        scopes.removeLast()
    }

    private func matchScope(_ type: ScopeType) -> Bool {
        return matchScope(where: { $0.type == type })
    }

    private func matchScope(_ keyPath: KeyPath<Scope, Bool>) -> Bool {
        return matchScope(where: { $0[keyPath: keyPath] })
    }

    private func matchScope(where predicate: (Scope) -> Bool) -> Bool {
        return scopes.reversed().reduce(false, { $0 || predicate($1) })
    }
}


// MARK: - private utility methods
extension Resolver {
    private func declare(_ name: Token) {
        scopes.last?.declare(name)
    }

    private func define(_ name: Token) {
        scopes.last?.define(name)
    }

    private func resolveLocal(_ name: Token) {
        for (index, scope) in scopes.enumerated().reversed() {
            if scope.knows(of: name) {
                let depth = scopes.count - 1 - index
                interpreter.resolve(name, depth: depth)
                break
            }
        }

        // not found; assume it is global
    }

    private func resolveFunction(_ function: FunctionDeclarationStatement, _ scopeType: ScopeType) throws {
        beginScope(type: scopeType)
        for param in function.parameters {
            declare(param.name)
            define(param.name)
        }
        try resolve(function.body)
        endScope()
    }
}


// MARK: - ASTVisitor
extension Resolver: ASTVisitor {
    func visitArrayLiteralExpression(_ expression: ArrayLiteralExpression) -> Result {
        return captureResult {
            for element in expression.elements {
                try resolve(element)
            }
        }
    }

    func visitAssignmentExpression(_ expression: AssignmentExpression) -> Result {
        return captureResult {
            try resolve(expression.value)
            resolveLocal(expression.identifier)
        }
    }

    func visitBinaryExpression(_ expression: BinaryExpression) -> Result {
        return captureResult {
            try resolve(expression.left)
            try resolve(expression.right)
        }
    }

    func visitCallExpression(_ expression: CallExpression) -> Result {
        return captureResult {
            try resolve(expression.callee)

            for argument in expression.arguments {
                try resolve(argument.value)
            }
        }
    }

    func visitGetExpression(_ expression: GetExpression) -> Result {
        return captureResult {
            try resolve(expression.object)
        }
    }

    func visitGroupingExpression(_ expression: GroupingExpression) -> Result {
        return captureResult {
            try resolve(expression.expression)
        }
    }

    func visitLiteralExpression(_ expression: LiteralExpression) -> Result {
        return .ok
    }

    func visitLogicalExpression(_ expression: LogicalExpression) -> Result {
        return captureResult {
            try resolve(expression.left)
            try resolve(expression.right)
        }
    }

    func visitSelfExpression(_ expression: SelfExpression) -> Result {
        return captureResult {
            guard matchScope(\.allowsSelfExpression) else {
                throw ResolverError(
                    code: .selfExpressionNotAllowed,
                    message: "cannot use `self` outside of a class",
                    location: expression.keyword.location
                )
            }

            resolveLocal(expression.keyword)
        }
    }

    func visitSetExpression(_ expression: SetExpression) -> Result {
        return captureResult {
            try resolve(expression.value)
            try resolve(expression.object)
        }
    }

    func visitSuperExpression(_ expression: SuperExpression) -> Result {
        return captureResult {
            guard matchScope(\.allowsSuperExpression) else {
                throw ResolverError(
                    code: .superExpressionNotAllowed,
                    message: "super is not allowed outside of a subclass",
                    location: expression.keyword.location
                )
            }

            resolveLocal(expression.keyword)
        }
    }

    func visitSuperSetExpression(_ expression: SuperSetExpression) -> Result {
        return captureResult {
            guard matchScope(\.allowsSuperExpression) else {
                throw ResolverError(
                    code: .superExpressionNotAllowed,
                    message: "super is not allowed outside of a subclass",
                    location: expression.keyword.location
                )
            }

            try resolve(expression.value)
            resolveLocal(expression.keyword)
        }
    }

    func visitUnaryExpression(_ expression: UnaryExpression) -> Result {
        return captureResult {
            try resolve(expression.expression)
        }
    }

    func visitVariableExpression(_ expression: VariableExpression) -> Result {
        return captureResult {
            if !scopes.isEmpty && scopes.last?.status(of: expression.identifier) == .declared {
                throw ResolverError(
                    code: .readingLocalValueWithinItsOwnInitializer,
                    message: "cannot read local variable in its own initializer",
                    location: expression.identifier.location
                )
            }

            resolveLocal(expression.identifier)
        }
    }

    func visitBlockStatement(_ statement: BlockStatement) -> Result {
        return captureResult {
            beginScope(type: .default)
            try resolve(statement.statements)
            try resolve(statement.atExit)
            endScope()
        }
    }

    func visitClassDeclarationStatement(_ statement: ClassDeclarationStatement) -> Result {
        return captureResult {
            declare(statement.name)
            define(statement.name)

            if let superclass = statement.superclass {
                try resolve(superclass)
                beginScope(type: .class)
                scopes.last?.classContext = .subclass
                scopes.last?.define("super")
            }

            beginScope(type: .class)
            scopes.last?.classContext = (statement.superclass != nil) ? .subclass : .rootClass
            scopes.last?.define(.self(at: statement.name.location))

            for initializer in statement.initializers {
                try resolveFunction(initializer, .initializer)
            }

            for property in statement.storedProperties {
                try resolve(property)
            }

            for property in statement.computedProperties {
                try resolve(property)
            }

            for method in statement.methods {
                try resolveFunction(method, .method)
            }

            endScope()

            if statement.superclass != nil {
                endScope()
            }
        }
    }

    func visitComputedPropertyDeclarationStatement(_ statement: ComputedPropertyDeclarationStatement) -> Result {
        return captureResult {
            declare(statement.name)
            beginScope(type: .property)
            try resolve(statement.getter)
            endScope()

            beginScope(type: .property)
            if let setter = statement.setter {
                declare(.newValue(at: statement.name.location))
                define(.newValue(at: statement.name.location))
                try resolve(setter)
            }
            endScope()

            define(statement.name)
        }
    }

    func visitExpressionStatement(_ statement: ExpressionStatement) -> Result {
        return captureResult {
            try resolve(statement.expression)
        }
    }

    func visitFunctionDeclarationStatement(_ statement: FunctionDeclarationStatement) -> Result {
        return captureResult {
            declare(statement.name)
            define(statement.name)
            try resolveFunction(statement, .function)
        }
    }

    func visitIfStatement(_ statement: IfStatement) -> Result {
        return captureResult {
            try resolve(statement.condition)
            try resolve(statement.thenStatement)
            if let elseStatement = statement.elseStatement {
                try resolve(elseStatement)
            }
        }
    }

    func visitImportStatement(_ statement: ImportStatement) -> Result {
        return captureResult {
            guard scopes.count == 1, scopes.last?.type == .global else {
                throw ResolverError(
                    code: .cannotImportAtNonGlobalScope,
                    message: "import statement is allowed only at global scope",
                    location: statement.identifier.location
                )
            }
        }
    }

    func visitPrintStatement(_ statement: PrintStatement) -> Result {
        return captureResult {
            try resolve(statement.expression)
        }
    }

    func visitReturnStatement(_ statement: ReturnStatement) -> Result {
        return captureResult {
            if matchScope(.initializer) && statement.value != nil {
                throw ResolverError(
                    code: .returnStatementNotAllowed,
                    message: "cannot return a value from an initializer",
                    location: statement.keyword.location
                )
            }

            guard matchScope(\.allowsReturnStatement) else {
                throw ResolverError(
                    code: .returnStatementNotAllowed,
                    message: "cannot return from top-level code",
                    location: statement.keyword.location
                )
            }

            guard let value = statement.value else {
                return
            }

            try resolve(value)
        }
    }

    func visitSingleKeywordStatement(_ statement: SingleKeywordStatement) -> Result {
        return .ok
    }

    func visitVariableDeclarationStatement(_ statement: VariableDeclarationStatement) -> Result {
        return captureResult {
            declare(statement.identifier)
            try resolve(statement.initializer)
            define(statement.identifier)
        }
    }

    func visitWhileStatement(_ statement: WhileStatement) -> Result {
        return captureResult {
            try resolve(statement.condition)
            try resolve(statement.body)
        }
    }
}
