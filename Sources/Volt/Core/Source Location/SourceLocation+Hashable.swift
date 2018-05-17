extension SourceLocation: Hashable {
    public var hashValue: Int {
        return line ^ offset
    }

    public static func == (left: SourceLocation, right: SourceLocation) -> Bool {
        return left.line == right.line && left.offset == right.offset
    }
}
