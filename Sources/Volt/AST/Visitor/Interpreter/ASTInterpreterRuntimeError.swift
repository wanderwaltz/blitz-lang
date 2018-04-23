struct ASTIntepreterRuntimeError: Error {
    enum Code: Int {
    case typeError = 1
    }

    let code: Code
    let message: String
}
