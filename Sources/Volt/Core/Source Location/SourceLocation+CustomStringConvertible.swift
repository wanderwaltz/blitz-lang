extension SourceLocation: CustomStringConvertible {
    var description: String {
        return "\(line):\(offset)"
    }
}
