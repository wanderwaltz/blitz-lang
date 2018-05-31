public enum RuntimeErrorCode: Int {
case cannotImportModule = 1
case cannotPrint
case internalInconsistency
case invalidCallee
case invalidCallSignature
case invalidGetExpression
case invalidNumberOfArguments
case invalidRedefenition
case invalidSetExpression
case invalidSuperclass
case settingImmutableValue
case typeError
case unknownIdentifier
case unknownProperty
}
