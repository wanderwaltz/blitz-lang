public protocol ImportedModulesSourceProvider {
    func sourceForModule(named name: String) throws -> String
}
