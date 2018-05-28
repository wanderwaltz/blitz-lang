extension Instance: Settable {
    func setProperty(named name: String, value: Value, interpreter: ASTInterpreter) throws {
        if let property = klass.storedProperties[name], property.isMutable {
            storedProperties[name] = value
            return
        }

        throw InternalError.unknownProperty(named: name)
    }
}
