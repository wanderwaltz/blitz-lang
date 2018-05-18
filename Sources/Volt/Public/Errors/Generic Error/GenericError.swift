public struct GenericError<_Code>: Error
where _Code: Hashable,
      _Code: ErrorDomainProviding,
      _Code: RawRepresentable,
      _Code.RawValue == Int {

    public typealias Code = _Code

    public let code: Code
    public let message: String
    public let location: SourceLocation

    public init(code: Code, message: String, location: SourceLocation) {
        self.code = code
        self.message = message
        self.location = location
    }
}


extension GenericError where _Code: ErrorMessageProviding {
    public init(code: Code, location: SourceLocation) {
        self.code = code
        self.message = code.errorMessage
        self.location = location
    }
}
