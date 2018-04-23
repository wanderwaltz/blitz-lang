struct Token {
    let type: TokenType
    let lexeme: String
    let literal: Literal?

    init(type: TokenType, lexeme: String) {
        precondition(type != .number, "number token requires a literal value")
        precondition(type != .string, "string token requires a literal value")
        self.type = type
        self.lexeme = lexeme
        self.literal = nil
    }

    init(literal value: Number, lexeme: String) {
        self.type = .number
        self.lexeme = lexeme
        self.literal = .number(value)
    }

    init(literal value: String, lexeme: String) {
        self.type = .string
        self.lexeme = lexeme
        self.literal = .string(value)
    }
}


extension Token {
    static let eof = Token(type: .eof, lexeme: "")
}
