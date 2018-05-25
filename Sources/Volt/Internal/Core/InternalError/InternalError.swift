enum InternalError: Error {
case invalidCallSignature(expected: CallSignature, got: CallSignature)
case invalidNumberOfArguments(expected: Int, got: Int)
case settingReadonlyProperty(named: String)
case typeError(expected: String, got: String)
case unknownProperty(named: String)
}
