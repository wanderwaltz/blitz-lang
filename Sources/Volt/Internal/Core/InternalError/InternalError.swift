enum InternalError: Error {
case invalidNumberOfArguments(expected: Int, got: Int)
case typeError(expected: String, got: String)
case unknownProperty(named: String)
case settingReadonlyProperty(named: String)
}
