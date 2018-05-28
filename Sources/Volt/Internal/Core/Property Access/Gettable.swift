protocol Gettable {
    func getProperty(named name: String, interpreter: ASTInterpreter) throws -> Value
}
