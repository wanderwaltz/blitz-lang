extension Instance: Settable {
    func setProperty(named name: String,
                     value: Value,
                     interpreter: Interpreter) throws {
        return try setProperty(named: name, value: value, inClass: klass, interpreter: interpreter)
    }

    func setProperty(named name: String,
                     value: Value,
                     inClass lookupClass: Class,
                     interpreter: Interpreter) throws {
        if let property = lookupClass.lookupStoredProperty(named: name) {
            guard property.isMutable else {
                throw RuntimeError.settingReadonlyProperty(named: name)
            }

            storedProperties[name] = value
            return
        }

        if let property = lookupClass.lookupComputedProperty(named: name) {
            guard let setter = property.setter else {
                throw RuntimeError.settingReadonlyProperty(named: name)
            }

            _ = try setter.bind(to: self).call(
                with: .init(
                    interpreter: interpreter,
                    signature: .init(components: [nil]),
                    arguments: [value]
                )
            )
            return
        }

        throw RuntimeError.unknownProperty(named: name)
    }
}
