public final class VM {
    public var importedModulesSourceProvider: ImportedModulesSourceProvider {
        get {
            return importedModulesProvider.sourceProvider
        }

        set {
            importedModulesProvider.sourceProvider = newValue
        }
    }

    public var print: (Value) -> Void = { Swift.print($0) }

    public let typeDelegates = TypeDelegatesRepository()

    public init() {
        interpreter = ASTInterpreter()
        resolver = ASTResolver(interpreter: interpreter)
        interpreter.delegate = self

        typeDelegates.registerDefaultBindings(for: String.self)
    }

    @discardableResult
    public func run(_ source: String) throws -> Value {
        let program = try parse(source)
        return try execute(program)
    }

    public func parse(_ source: String) throws -> Program {
        let tokens = try Scanner().process(source)
        let statements = try Parser().parse(tokens)
        try resolver.resolve(statements)
        return Program(statements: statements)
    }

    @discardableResult
    public func execute(_ program: Program) throws -> Value {
        switch interpreter.execute(program.statements) {
        case let .value(value):
            return value

        case let .runtimeError(error):
            throw error

        case let .throwable(command):
            throw RuntimeError(
                code: .internalInconsistency,
                message: "internal inconsistency: unhandled \(command) received",
                location: .unknown
            )
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

    func interpreter(_ interpreter: ASTInterpreter, print value: Value) {
        print(value)
    }

    func interpreter(_ interpreter: ASTInterpreter, gettableFor value: Value) -> Gettable? {
        return typeDelegates.gettable(for: value)
    }
}
