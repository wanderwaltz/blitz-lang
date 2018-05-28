extension Token {
    static let eof = Token(type: .eof, lexeme: "", location: .init(line: -1, offset: -1))

    static func `self`(at location: SourceLocation) -> Token {
        return Token(type: .self, lexeme: "self", location: location)
    }
}
