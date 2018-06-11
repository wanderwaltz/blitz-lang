extension Interpreter {
    func rawGet(propertyOf object: Value, named name: Token) throws -> Value {
        let gettable = try lookupGettable(for: object)
        return try gettable.getProperty(named: name.lexeme, interpreter: self)
    }

    private func lookupGettable(for object: Value) throws -> Gettable {
        if case let .object(gettable as Gettable) = object {
            return gettable
        }

        guard let delegate = delegate else {
            throw RuntimeError.invalidGetProperty(of: object, reason: "interpreter delegate is not set")
        }

        guard let gettable = delegate.interpreter(self, gettableFor: object) else {
            throw RuntimeError.invalidGetProperty(of: object)
        }

        return gettable
    }
}
