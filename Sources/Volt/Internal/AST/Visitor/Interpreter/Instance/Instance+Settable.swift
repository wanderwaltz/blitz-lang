extension Instance: Settable {
    func setProperty(named name: String, value: Value, interpreter: ASTInterpreter) throws {
        if let property = klass.storedProperties[name] {
            guard property.isMutable else {
                throw InternalError.settingReadonlyProperty(named: name)
            }

            storedProperties[name] = value
            return
        }

        throw InternalError.unknownProperty(named: name)
    }
}
