public enum RuntimeErrorCode: Int {
case cannotImportModule = 1
case internalInconsistency
case invalidCallee
case invalidNumberOfArguments
case invalidRedefenition
case settingImmutableValue
case typeError
case unknownIdentifier
}
