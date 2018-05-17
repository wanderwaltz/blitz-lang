public struct ParserError: Error {
    public let message: String
    public let location: SourceLocation
}
