extension ParserError: CustomStringConvertible {
    public var description: String {
        return "Line \(location): \(message)"
    }
}
