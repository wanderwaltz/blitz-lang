final class SlidingWindowTokenStream {
    init(advance: @escaping () throws -> Token) throws {
        self._advance = advance
        _current = try advance()
        _next = try advance()
    }

    private let _advance: () throws -> Token?

    private var _previous: Token?
    private var _current: Token?
    private var _next: Token?
}


extension SlidingWindowTokenStream: TokenStream {
    func previous() -> Token {
        return _previous ?? .eof
    }

    func peek() -> Token {
        return _current ?? .eof
    }

    func peekNext() -> Token {
        return _next ?? .eof
    }

    func advance() throws -> Token {
        _previous = _current
        _current = _next
        _next = try _advance()
        return previous()
    }
}
