struct ASTIntepreterRuntimeError: Error {
    enum Code: Int {
    case typeError = 1
    case invalidRedefenition = 2
    case unknownIdentifier = 3
    case settingImmutableValue = 4
    }

    let code: Code
    let message: String
}
