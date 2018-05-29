extension Instance: VoltStringConvertible {
    func voltDescription(interpreter: ASTInterpreter) throws -> String? {
        if let value = try lookupProperty(named: descriptionKey, interpreter: interpreter) {
            return String(describing: value)
        }

        if case let .some(.object(callable as Callable)) =  lookupMethod(named: descriptionKey) {
            return String(
                describing: try callable.call(
                    interpreter: interpreter,
                    signature: .void,
                    arguments: []
                )
            )
        }

        return nil
    }
}

private let descriptionKey = "description"
