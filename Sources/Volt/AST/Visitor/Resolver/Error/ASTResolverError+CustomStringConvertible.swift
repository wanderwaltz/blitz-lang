extension ASTResolverError: CustomStringConvertible {
    public var description: String {
        return "Line \(location): \(message)"
    }
}
