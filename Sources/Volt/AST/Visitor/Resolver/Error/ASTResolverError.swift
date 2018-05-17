public struct ASTResolverError: Error {
    public let message: String
    public let location: SourceLocation
}
