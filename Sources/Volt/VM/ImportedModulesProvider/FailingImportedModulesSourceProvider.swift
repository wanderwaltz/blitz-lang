struct FailingImportedModulesSourceProvider: ImportedModulesSourceProvider {
    struct Error: Swift.Error {
        let message: String
    }

    func sourceForModule(named name: String) throws -> String {
        throw Error(message: "unable to import modules: no ImportedModulesSourceProvider")
    }
}
