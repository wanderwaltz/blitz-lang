protocol Settable {
    func setProperty(named name: String, value: Value, interpreter: Interpreter) throws
}
