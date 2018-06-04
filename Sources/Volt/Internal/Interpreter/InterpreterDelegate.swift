protocol InterpreterDelegate: class {
    func interpreter(_ interpreter: Interpreter, importModuleNamed name: String) throws
        -> ImportedModulesProvider.Result

    func interpreter(_ interpreter: Interpreter, print value: Value)

    func interpreter(_ interpreter: Interpreter, gettableFor value: Value) -> Gettable?
    func interpreter(_ interpreter: Interpreter, settableFor value: Value) -> Settable?
}
