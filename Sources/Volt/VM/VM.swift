public final class VM {
    public init() {}

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
        switch interpreter.execute(program.statements) {
        case let .value(value): return value
        case let .runtimeError(error): throw error
        }
    }

    private let interpreter = ASTInterpreter()
}
