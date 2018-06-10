// MARK: - <Gettable> default implementation
extension TypeInfo {
    func getProperty(named name: String, interpreter: Interpreter) throws -> Value {
        if let method = lookupMethod(named: name) {
            return .object(method)
        }

        throw RuntimeError.unknownProperty(named: name)
    }
}
