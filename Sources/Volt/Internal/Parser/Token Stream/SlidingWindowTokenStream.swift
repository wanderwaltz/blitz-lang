final class SlidingWindowTokenStream {
    init(advance: @escaping () throws -> Token) throws {
        self._advance = advance
        _current = try advance()
    }

    private let _advance: () throws -> Token?

    private var _previous: Token?
    private var _current: Token?
}


extension SlidingWindowTokenStream: TokenStream {
    func previous() -> Token {
        return _previous ?? .eof
    }

    func peek() -> Token {
        return _current ?? .eof
    }

    func advance() throws -> Token {
        _previous = _current
        _current = try _advance()
        return previous()
    }
}
