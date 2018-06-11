extension SourceLocation: CustomStringConvertible {
    public var description: String {
        guard self != .unknown else {
            return "<unknown location>"
        }

        return "\(line):\(offset)"
    }
}
