extension Interpreter {
    /// Calculates result of performing x-assignment operators such as `+=`, `-=`, `/=` and `*=`
    /// given a right-hand side `newValue` and left-hand side `existingValue`, for example:
    ///
    ///    existingValue += newValue
    ///
    func rawAssignment(of newValue: Value, applying op: Token, to existingValue: Value) throws -> Value {
        let location = op.location

        switch op.type {
        case .minusEqual:
            return try unwrap(existingValue.subtracting(newValue, at: location))

        case .plusEqual:
            return try unwrap(existingValue.adding(newValue, at: location))

        case .slashEqual:
            return try unwrap(existingValue.dividing(by: newValue, at: location))

        case .starEqual:
            return try unwrap(existingValue.multiplying(by: newValue, at: location))

        default:
            preconditionFailure("unimplemented assignment operator \(op)")
        }
    }

    func rawSet(propertyOf object: Value, named name: Token, newValue value: Value) throws -> Value {
        let settable = try lookupSettable(for: object)
        try settable.setProperty(named: name.lexeme, value: value, interpreter: self)
        return value
    }

    private func lookupSettable(for object: Value) throws -> Settable {
        if case let .object(settable as Settable) = object {
            return settable
        }

        guard let delegate = delegate else {
            throw RuntimeError.invalidSetProperty(of: object, reason: "interpreter delegate is not set")
        }

        guard let settable = delegate.interpreter(self, settableFor: object) else {
            throw RuntimeError.invalidSetProperty(of: object)
        }

        return settable
    }
}
