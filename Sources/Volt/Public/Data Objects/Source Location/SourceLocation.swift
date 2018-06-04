public struct SourceLocation {
    public let line: Int
    public let offset: Int
}


extension SourceLocation {
    public static let unknown = SourceLocation(line: -1, offset: 0)
}
