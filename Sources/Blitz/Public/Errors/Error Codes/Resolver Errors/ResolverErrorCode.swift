public enum ResolverErrorCode: Int {
case cannotImportAtNonGlobalScope = 1
case readingLocalValueWithinItsOwnInitializer
case returnStatementNotAllowed
case selfExpressionNotAllowed
case superExpressionNotAllowed
}
