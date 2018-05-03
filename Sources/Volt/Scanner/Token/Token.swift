struct Token {
    let type: TokenType
    let lexeme: String
    let location: SourceLocation

    let literal: Literal?

    init(type: TokenType, lexeme: String, location: SourceLocation) {
        precondition(type != .number, "number token requires a literal value")
        precondition(type != .string, "string token requires a literal value")
        self.type = type
        self.lexeme = lexeme
        self.location = location
        self.literal = nil
    }

    init(literal value: Number, lexeme: String, location: SourceLocation) {
        self.type = .number
        self.lexeme = lexeme
        self.location = location
        self.literal = .number(value)
    }

    init(literal value: String, lexeme: String, location: SourceLocation) {
        self.type = .string
        self.lexeme = lexeme
        self.location = location
        self.literal = .string(value)
    }
}


extension Token {
    static let eof = Token(type: .eof, lexeme: "", location: .init(line: -1, offset: -1))
}
