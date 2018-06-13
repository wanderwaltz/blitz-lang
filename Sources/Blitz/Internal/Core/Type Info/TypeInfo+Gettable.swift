// MARK: - <Gettable> default implementation

/// Static class properties and unbound instance methods are gettable via a TypeInfo.
extension TypeInfo {
    func getProperty(named name: String, interpreter: Interpreter) throws -> Value {
        if let method = lookupMethod(named: name) {
            return .init(method)
        }

        throw RuntimeError.unknownProperty(named: name)
    }
}
