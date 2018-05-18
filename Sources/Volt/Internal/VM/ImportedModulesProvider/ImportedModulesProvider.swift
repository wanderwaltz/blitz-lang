final class ImportedModulesProvider {
    enum Result {
    case new(Program)
    case alreadyImported
    }

    var sourceProvider: ImportedModulesSourceProvider = FailingImportedModulesSourceProvider()

    func importModule(named name: String) throws -> Result {
        guard !alreadyImportedModules.contains(name) else {
            return .alreadyImported
        }

        let source = try sourceProvider.sourceForModule(named: name)
        let tokens = try Scanner().process(source)
        let statements = try Parser().parse(tokens)
        return .new(Program(statements: statements))
    }

    private var alreadyImportedModules = Set<String>()
}
