extension Instance: Gettable {
    func getProperty(named name: String, interpreter: ASTInterpreter) throws -> Value {
        if let method = klass.methods[name] {
            return .object(method.bind(to: self))
        }

        throw InternalError.unknownProperty(named: name)
    }
}
