public struct ASTIntepreterRuntimeError: Error {
    public enum Code: Int {
    case typeError = 1
    case invalidRedefenition = 2
    case unknownIdentifier = 3
    case settingImmutableValue = 4
    case cannotImportModule = 5
    case `break` = 6
    case `continue` = 7
    }

    public let code: Code
    public let message: String
    public let location: SourceLocation
}
