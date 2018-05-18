extension GenericError: CustomStringConvertible {
    public var description: String {
        return "[\(code.rawValue)] at \(location): \(message)"
    }
}
