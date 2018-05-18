enum InternalError: Error {
case invalidNumberOfArguments(expected: Int, got: Int)
case typeError(expected: String, got: String)
case unknownProperty(named: String)
}
