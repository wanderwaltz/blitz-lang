extension Token {
    var numberValue: Number? {
        guard type == .number else {
            return nil
        }

        guard let value = literal as? Number else {
            preconditionFailure("number token requires a literal value")
        }

        return value
    }
}
