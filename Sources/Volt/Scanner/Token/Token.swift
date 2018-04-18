struct Token {
    let type: TokenType
    let lexeme: String
    let literal: Any?

    init(type: TokenType, lexeme: String) {
        precondition(type != .number, "number token requires a literal value")
        self.type = type
        self.lexeme = lexeme
        self.literal = nil
    }

    init(literal: Number, lexeme: String) {
        self.type = .number
        self.lexeme = lexeme
        self.literal = literal
    }
}
