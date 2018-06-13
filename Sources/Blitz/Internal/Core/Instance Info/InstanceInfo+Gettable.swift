// MARK: - <Gettable> default implementation
extension InstanceInfo {
    func getProperty(named name: String, interpreter: Interpreter) throws -> Value {
        return try getProperty(named: name, inClass: klass, interpreter: interpreter)
    }

    func getProperty(named name: String,
                     inClass lookupClass: Klass,
                     interpreter: Interpreter) throws -> Value {
        let optionalValue = try lookupProperty(named: name, inClass: lookupClass, interpreter: interpreter)
            ?? lookupMethod(named: name, inClass: lookupClass)

        guard let value = optionalValue else {
            throw RuntimeError.unknownProperty(named: name)
        }

        return value
    }
}


extension InstanceInfo {
    func lookupProperty(named name: String,
                        inClass lookupClass: Klass,
                        interpreter: Interpreter) throws -> Value? {
        return try lookupStoredProperty(named: name)
            ?? lookupComputedProperty(named: name, inClass: lookupClass, interpreter: interpreter)
    }

    private func lookupComputedProperty(named name: String,
                                        inClass lookupClass: Klass,
                                        interpreter: Interpreter) throws -> Value? {
        guard let property = lookupClass.lookupComputedProperty(named: name) else {
            return nil
        }

        let getter = try property.getter.bind(to: self)

        return try getter.call(
            with: .init(
                interpreter: interpreter,
                signature: .void,
                arguments: []
            )
        )
    }
}


extension InstanceInfo {
    func lookupMethod(named name: String, inClass lookupClass: Klass) throws -> Value? {
        guard let method = lookupClass.lookupMethod(named: name) else {
            return nil
        }

        return .init(try method.bind(to: self))
    }
}
