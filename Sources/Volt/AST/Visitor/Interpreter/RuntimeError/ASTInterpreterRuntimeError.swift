public struct ASTIntepreterRuntimeError: Error {
    public enum Code: Int {
    case typeError = 1
    case invalidRedefenition
    case unknownIdentifier
    case settingImmutableValue
    case cannotImportModule
    case invalidCallee
    case invalidNumberOfArguments
    case `break`
    case `continue`
    }

    public let code: Code
    public let message: String
    public let location: SourceLocation
}
