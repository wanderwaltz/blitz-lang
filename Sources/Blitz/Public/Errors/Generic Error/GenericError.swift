public struct GenericError<_Code>: Error
where _Code: Hashable,
      _Code: ErrorDomainProviding,
      _Code: RawRepresentable,
      _Code.RawValue == Int {

    public typealias Code = _Code

    public let code: Code
    public let message: String
    public let underlyingError: Error?
    public let location: SourceLocation

    public init(code: Code, message: String, location: SourceLocation = .unknown, underlyingError: Error? = nil) {
        self.code = code
        self.message = message
        self.location = location
        self.underlyingError = underlyingError
    }
}


extension GenericError where _Code: ErrorMessageProviding {
    public init(code: Code, location: SourceLocation = .unknown, underlyingError: Error? = nil) {
        self.code = code
        self.message = code.errorMessage
        self.location = location
        self.underlyingError = underlyingError
    }
}


extension GenericError {
    func defaultingLocation(to estimateLocation: SourceLocation) -> GenericError {
        guard location == .unknown else {
            return self
        }

        return .init(
            code: code,
            message: message,
            location: estimateLocation,
            underlyingError: underlyingError
        )
    }
}
