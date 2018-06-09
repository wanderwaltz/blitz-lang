extension Instance: VoltStringConvertible {
    func voltDescription(interpreter: Interpreter) throws -> String? {
        if let value = try lookupProperty(named: descriptionKey, inClass: klass, interpreter: interpreter) {
            return String(describing: value)
        }

        if case let .some(.object(callable as Callable)) = try lookupMethod(named: descriptionKey, inClass: klass) {
            return String(
                describing: try callable.call(
                    with: .init(
                        interpreter: interpreter,
                        signature: .void,
                        arguments: []
                    )
                )
            )
        }

        return nil
    }
}

private let descriptionKey = "description"
