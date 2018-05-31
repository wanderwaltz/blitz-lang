extension Instance: Gettable {
    func getProperty(named name: String, interpreter: ASTInterpreter) throws -> Value {
        return try getProperty(named: name, inClass: klass, interpreter: interpreter)
    }

    /// This method is added for supporting `super` lookups where `lookupClass` may actually
    /// be the `superclass` of the `klass`.
    func getProperty(named name: String,
                     inClass lookupClass: Class,
                     interpreter: ASTInterpreter) throws -> Value {
        let optionalValue = try lookupProperty(named: name, inClass: lookupClass, interpreter: interpreter)
            ?? lookupMethod(named: name, inClass: lookupClass)

        guard let value = optionalValue else {
            throw InternalError.unknownProperty(named: name)
        }

        return value
    }
}


extension Instance {
    func lookupProperty(named name: String,
                        inClass lookupClass: Class,
                        interpreter: ASTInterpreter) throws -> Value? {
        return try lookupStoredProperty(named: name)
            ?? lookupComputedProperty(named: name, inClass: lookupClass, interpreter: interpreter)
    }

    private func lookupStoredProperty(named name: String) -> Value? {
        return storedProperties[name]
    }

    private func lookupComputedProperty(named name: String,
                                        inClass lookupClass: Class,
                                        interpreter: ASTInterpreter) throws -> Value? {
        guard let property = lookupClass.lookupComputedProperty(named: name) else {
            return nil
        }

        let getter = property.getter.bind(to: self)

        return try getter.call(
            interpreter: interpreter,
            signature: .void,
            arguments: []
        )
    }
}


extension Instance {
    func lookupMethod(named name: String, inClass lookupClass: Class) -> Value? {
        guard let method = lookupClass.lookupMethod(named: name) else {
            return nil
        }

        return .object(method.bind(to: self))
    }
}
