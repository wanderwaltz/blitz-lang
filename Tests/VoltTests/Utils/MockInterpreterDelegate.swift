@testable import Volt

final class MockInterpreterDelegate {
    var printedValues: [Value] = []

    var `import`: (String) throws -> ImportedModulesProvider.Result = { _ in
        throw RuntimeError(code: .cannotImportModule, message: "not implemented", location: .unknown)
    }

    let typeDelegates = TypeDelegatesRepository()

    init() {
        typeDelegates.registerDefaultBindings(for: String.self)
    }
}

extension MockInterpreterDelegate: ASTInterpreterDelegate {
    func interpreter(_ interpreter: ASTInterpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result {
            return try `import`(name)
        }

    func interpreter(_ interpreter: ASTInterpreter, print value: Value) {
        printedValues.append(value)
    }

    func interpreter(_ interpreter: ASTInterpreter, gettableFor value: Value) -> Gettable? {
        return typeDelegates.gettable(for: value)
    }

    func interpreter(_ interpreter: ASTInterpreter, settableFor value: Value) -> Settable? {
        return typeDelegates.settable(for: value)
    }
}
