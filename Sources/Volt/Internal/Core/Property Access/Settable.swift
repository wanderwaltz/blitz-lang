protocol Settable {
    func setProperty(named name: String, value: Value, interpreter: ASTInterpreter) throws
}
