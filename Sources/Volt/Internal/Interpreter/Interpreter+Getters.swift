extension Interpreter {
    func rawGet(propertyOf object: Value, named name: Token) throws -> Value {
        let location = name.location
        let gettable = try lookupGettable(for: object, at: location)

        do {
            return try gettable.getProperty(named: name.lexeme, interpreter: self)
        }
        catch let internalError as InternalError {
            throw internalError.makeRuntimeError(location: location)
        }
    }

    private func lookupGettable(for object: Value, at location: SourceLocation) throws -> Gettable {
        if case let .object(gettable as Gettable) = object {
            return gettable
        }

        guard let delegate = delegate else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot read properties of type '\(object.typeName)': interpreter delegate is not set",
                location: location
            )
        }

        guard let gettable = delegate.interpreter(self, gettableFor: object) else {
            throw RuntimeError(
                code: .invalidGetExpression,
                message: "cannot read properties on object of type \(object.typeName)",
                location: location
            )
        }

        return gettable
    }
}
