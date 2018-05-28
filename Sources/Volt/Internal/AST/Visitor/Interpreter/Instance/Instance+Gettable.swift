extension Instance: Gettable {
    func getProperty(named name: String, interpreter: ASTInterpreter) throws -> Value {
        let optionalValue = lookupProperty(named: name, interpreter: interpreter)
            ?? lookupMethod(named: name)

        guard let value = optionalValue else {
            throw InternalError.unknownProperty(named: name)
        }

        return value
    }
}


extension Instance {
    func lookupProperty(named name: String, interpreter: ASTInterpreter) -> Value? {
        return lookupStoredProperty(named: name)
    }

    private func lookupStoredProperty(named name: String) -> Value? {
        return storedProperties[name]
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
