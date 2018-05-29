extension Instance: Gettable {
    func getProperty(named name: String, interpreter: ASTInterpreter) throws -> Value {
        let optionalValue = try lookupProperty(named: name, interpreter: interpreter)
            ?? lookupMethod(named: name)

        guard let value = optionalValue else {
            throw InternalError.unknownProperty(named: name)
        }

        return value
    }
}


extension Instance {
    func lookupProperty(named name: String, interpreter: ASTInterpreter) throws -> Value? {
        return try lookupStoredProperty(named: name)
            ?? lookupComputedProperty(named: name, interpreter: interpreter)
    }

    private func lookupStoredProperty(named name: String) -> Value? {
        return storedProperties[name]
    }

    private func lookupComputedProperty(named name: String, interpreter: ASTInterpreter) throws -> Value? {
        guard let property = klass.computedProperties[name] else {
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
    func lookupMethod(named name: String) -> Value? {
        guard let method = klass.methods[name] else {
            return nil
        }

        return .object(method.bind(to: self))
    }
}
