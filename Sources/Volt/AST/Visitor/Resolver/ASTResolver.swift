// MARK: - ASTResolver
final class ASTResolver {
    typealias Interpreter = ASTInterpreter
    typealias Scope = ASTResolverScope
    typealias Result = ASTResolverResult

    init(interpreter: Interpreter) {
        self.interpreter = interpreter
    }

    private let interpreter: Interpreter
    private var scopes: [Scope] = []
}


// MARK: - utility methods
extension ASTResolver {
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
extension ASTResolver {
    private func captureResult(_ block: () throws -> Void) -> Result {
        do {
            try block()
            return .ok
        }
        catch let error as ASTResolverError {
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


// MARK: - private utility methods
extension ASTResolver {
    private func beginScope() {
        scopes.append(.init())
    }

    private func endScope() {
        scopes.removeLast()
    }

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
            }
        }

        // not found; assume it is global
    }

    private func resolveFunction(_ function: FunctionDeclarationStatement) throws {
        beginScope()
        for param in function.parameters {
            declare(param)
            define(param)
        }
        try resolve(function.body)
        endScope()
    }
}


// MARK: - ASTVisitor
extension ASTResolver: ASTVisitor {
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
                try resolve(argument)
            }
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

    func visitUnaryExpression(_ expression: UnaryExpression) -> Result {
        return captureResult {
            try resolve(expression.expression)
        }
    }

    func visitVariableExpression(_ expression: VariableExpression) -> Result {
        return captureResult {
            if !scopes.isEmpty && scopes.last?.status(of: expression.identifier) == .declared {
                throw ASTResolverError(
                    message: "cannot read local variable in its own initializer",
                    location: expression.identifier.location
                )
            }

            resolveLocal(expression.identifier)
        }
    }

    func visitBlockStatement(_ statement: BlockStatement) -> Result {
        return captureResult {
            beginScope()
            try resolve(statement.statements)
            try resolve(statement.atExit)
            endScope()
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
            try resolveFunction(statement)
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
        return .ok
    }

    func visitPrintStatement(_ statement: PrintStatement) -> Result {
        return captureResult {
            try resolve(statement.expression)
        }
    }

    func visitReturnStatement(_ statement: ReturnStatement) -> Result {
        return captureResult {
            try resolve(statement.value)
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