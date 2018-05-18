extension InternalError {
    func makeRuntimeError(location: SourceLocation) -> RuntimeError {
        switch self {
        case let .invalidNumberOfArguments(expected, got):
            return RuntimeError(
                code: .invalidNumberOfArguments,
                message: "invalid number of arguments: expected \(expected), got: \(got)",
                location: location
            )

        case let .typeError(expected, got):
            return RuntimeError(
                code: .typeError,
                message: "type error: expected \(expected), got: \(got)",
                location: location
            )

        case let .unknownProperty(name):
            return RuntimeError(
                code: .unknownProperty,
                message: "unknown property '\(name)'",
                location: location
            )
        }
    }
}
