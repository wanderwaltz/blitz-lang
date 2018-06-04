protocol Gettable {
    func getProperty(named name: String, interpreter: Interpreter) throws -> Value
}
