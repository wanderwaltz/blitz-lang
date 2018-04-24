extension ASTIntepreterRuntimeError: CustomStringConvertible {
    var description: String {
        return "[\(code.rawValue)]: \(message)"
    }
}
