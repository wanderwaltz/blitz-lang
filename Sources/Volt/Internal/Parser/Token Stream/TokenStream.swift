protocol TokenStream {
    /// should return .eof if no more tokens
    func previous() -> Token

    /// should return .eof if no more tokens
    func peek() -> Token

    /// should return .eof if no more tokens
    func advance() throws -> Token
}