extension ASTIntepreterRuntimeError: CustomStringConvertible {
    var description: String {
        return "[\(code.rawValue)] line \(location): \(message)"
    }
}
