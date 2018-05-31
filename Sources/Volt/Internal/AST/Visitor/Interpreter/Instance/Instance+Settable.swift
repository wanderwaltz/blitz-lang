extension Instance: Settable {
    func setProperty(named name: String,
                     value: Value,
                     interpreter: ASTInterpreter) throws {
        return try setProperty(named: name, value: value, inClass: klass, interpreter: interpreter)
    }

    func setProperty(named name: String,
                     value: Value,
                     inClass lookupClass: Class,
                     interpreter: ASTInterpreter) throws {
        if let property = klass.storedProperties[name] {
            guard property.isMutable else {
                throw InternalError.settingReadonlyProperty(named: name)
            }

            storedProperties[name] = value
            return
        }

        if let property = lookupClass.lookupComputedProperty(named: name) {
            guard let setter = property.setter else {
                throw InternalError.settingReadonlyProperty(named: name)
            }

            _ = try setter.bind(to: self).call(
                interpreter: interpreter,
                signature: .init(components: [nil]),
                arguments: [value]
            )
            return
        }

        throw InternalError.unknownProperty(named: name)
    }
}
