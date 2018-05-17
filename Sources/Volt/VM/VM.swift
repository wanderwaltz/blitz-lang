public final class VM {
    public var importedModulesSourceProvider: ImportedModulesSourceProvider {
        get {
            return importedModulesProvider.sourceProvider
        }

        set {
            importedModulesProvider.sourceProvider = newValue
        }
    }

    public init() {
        interpreter = ASTInterpreter()
        resolver = ASTResolver(interpreter: interpreter)
        interpreter.delegate = self
    }

    @discardableResult
    public func run(_ source: String) throws -> Value {
        let program = try parse(source)
        return try execute(program)
    }

    public func parse(_ source: String) throws -> Program {
        let tokens = try Scanner().process(source)
        let statements = try Parser().parse(tokens)
        return Program(statements: statements)
    }

    @discardableResult
    public func execute(_ program: Program) throws -> Value {
        try resolver.resolve(program.statements)

        switch interpreter.execute(program.statements) {
        case let .value(value): return value
        case let .runtimeError(error): throw error

        // TODO: make unhandled throwable command a separate error
        case let .throwable(command): throw command
        }
    }

    private let resolver: ASTResolver
    private let interpreter: ASTInterpreter
    private let importedModulesProvider = ImportedModulesProvider()
}


extension VM: ASTInterpreterDelegate {
    func interpreter(_ interpreter: ASTInterpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result {
            let result = try importedModulesProvider.importModule(named: name)

            if case let .new(program) = result {
                try resolver.resolve(program.statements)
            }

            return result
    }
}
