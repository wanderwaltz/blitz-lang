protocol ASTInterpreterDelegate: class {
    func interpreter(_ interpreter: ASTInterpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result

    func interpreter(_ interpreter: ASTInterpreter, print value: Value)

    func stringDelegateForInterpreter(_ interpreter: ASTInterpreter) -> StringDelegate
}
