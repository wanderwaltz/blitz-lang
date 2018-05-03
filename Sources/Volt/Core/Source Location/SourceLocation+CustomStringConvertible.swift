extension SourceLocation: CustomStringConvertible {
    public var description: String {
        return "\(line):\(offset)"
    }
}
