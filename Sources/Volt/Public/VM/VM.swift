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
        interpreter = Interpreter()
        resolver = Resolver(interpreter: interpreter)
        interpreter.delegate = self

        registerDefaultGlobals()
        typeDelegates.registerDefaultBindings(for: String.self)
        typeDelegates.registerDefaultArrayBindings()
    }

    @discardableResult
    public func run(_ source: String) throws -> Value {
        let program = try parse(source)
        return try execute(program)
    }

    public func parse(_ source: String) throws -> Program {
        let tokens = try Scanner().tokenStream(for: source)
        let statements = try Parser().parse(tokens)
        try resolver.resolve(statements)
        return Program(statements: statements)
    }

    @discardableResult
    public func execute(_ program: Program) throws -> Value {
        switch resultOfExecuting(program) {
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

    func resultOfExecuting(_ program: Program) -> InterpreterResult {
        return interpreter.execute(program.statements)
    }

    private let resolver: Resolver
    private let interpreter: Interpreter
    private let importedModulesProvider = ImportedModulesProvider()
}


extension VM {
    public func defineGlobal<T>(named name: String, value: T, isMutable: Bool = false) {
        interpreter.rootEnvironment.forceDefineVariable(
            named: .init(
                type: .identifier,
                lexeme: name,
                location: .unknown
            ),
            value: .init(value),
            isMutable: isMutable
        )
    }
}


extension VM: InterpreterDelegate {
    func interpreter(_ interpreter: Interpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result {
            let result = try importedModulesProvider.importModule(named: name)

            if case let .new(program) = result {
                try resolver.resolve(program.statements)
            }

            return result
    }

    func interpreter(_ interpreter: Interpreter, print value: Value) {
        print(value)
    }

    func interpreter(_ interpreter: Interpreter, gettableFor value: Value) -> Gettable? {
        return typeDelegates.gettable(for: value)
    }

    func interpreter(_ interpreter: Interpreter, settableFor value: Value) -> Settable? {
        return typeDelegates.settable(for: value)
    }
}
