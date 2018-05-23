protocol ASTInterpreterDelegate: class {
    func interpreter(_ interpreter: ASTInterpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result

    func interpreter(_ interpreter: ASTInterpreter, print value: Value)

    func interpreter(_ interpreter: ASTInterpreter, gettableFor value: Value) -> Gettable?
    func interpreter(_ interpreter: ASTInterpreter, settableFor value: Value) -> Settable?
}
