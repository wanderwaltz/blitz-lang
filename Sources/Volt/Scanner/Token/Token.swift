struct Token {
    let type: TokenType
    let lexeme: String
    let literal: Literal?

    init(type: TokenType, lexeme: String) {
        precondition(type != .number, "number token requires a literal value")
        self.type = type
        self.lexeme = lexeme
        self.literal = nil
    }

    init(literal value: Number, lexeme: String) {
        self.type = .number
        self.lexeme = lexeme
        self.literal = .number(value)
    }
}
