extension ScannerErrorCode: ErrorMessageProviding {
    public var errorMessage: String {
        switch self {
        case .failedParsingNumberLiteral: return "failed parsing number literal"
        case .unexpectedToken: return "unexpected token"
        case .unterminatedString: return "unterminated string literal"
        }
    }
}
