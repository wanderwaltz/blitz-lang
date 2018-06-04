extension Token {
    static let eof = Token(type: .eof, lexeme: "", location: .init(line: -1, offset: -1))

    static func `self`(at location: SourceLocation) -> Token {
        return Token(type: .self, lexeme: "self", location: location)
    }

    static func labellessFuncPrameter(at location: SourceLocation) -> Token {
        return Token(type: .identifier, lexeme: "_", location: location)
    }

    static func newValue(at location: SourceLocation) -> Token {
        return Token(type: .identifier, lexeme: "newValue", location: location)
    }
}
