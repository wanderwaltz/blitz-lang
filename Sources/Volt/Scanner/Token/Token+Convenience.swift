extension Token {
    var numberValue: Number? {
        guard type == .number else {
            return nil
        }

        guard case let .some(.number(value)) = literal else {
            preconditionFailure("number token requires a literal value")
        }

        return value
    }
}
