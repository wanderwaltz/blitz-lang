extension GenericError: CustomStringConvertible {
    public var description: String {
        return "\(Code.errorDomainDescription) [\(code.rawValue)] at \(location): \(message)"
    }
}
