struct ASTIntepreterRuntimeError: Error {
    enum Code: Int {
    case typeError = 1
    case invalidRedefenition = 2
    case unknownIdentifier = 3
    case settingImmutableValue = 4
    case cannotImportModule = 5
    case `break` = 6
    case `continue` = 7
    }

    let code: Code
    let message: String
}
