extension Token {
    // MARK: - numberValue
    var numberValue: Number? {
        switch type {
        case .number: return rawNumberLiteralValue
        case .string: return numberParsedFromStringLiteral
        default: return nil
        }
    }

    private var rawNumberLiteralValue: Number {
        guard case let .some(.number(value)) = literal else {
            preconditionFailure("number token requires a literal value")
        }

        return value
    }

    private var numberParsedFromStringLiteral: Number? {
        guard case let .some(.string(value)) = literal else {
            preconditionFailure("string token requires a literal value")
        }

        return Number(value)
    }


    // MARK: - stringValue
    var stringValue: String? {
        switch type {
        case .string: return rawStringLiteralValue
        case .number: return stringRepresentationOfNumberLiteral
        default: return nil
        }
    }

    private var rawStringLiteralValue: String {
        guard case let .some(.string(value)) = literal else {
            preconditionFailure("string token requires a literal value")
        }

        return value
    }

    private var stringRepresentationOfNumberLiteral: String {
        guard case let .some(.number(value)) = literal else {
            preconditionFailure("number token requires a literal value")
        }

        return String(describing: value)
    }
}
