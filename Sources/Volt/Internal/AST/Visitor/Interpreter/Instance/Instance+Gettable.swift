extension Instance: Gettable {
    func getProperty(named name: String) throws -> Value {
        if let method = klass.methods[name] {
            return .object(method)
        }

        throw InternalError.unknownProperty(named: name)
    }
}
