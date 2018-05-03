extension ASTIntepreterRuntimeError: CustomStringConvertible {
    public var description: String {
        return "[\(code.rawValue)] line \(location): \(message)"
    }
}
