extension ScannerError: CustomStringConvertible {
    var description: String {
        switch code {
        case .unexpectedToken:
            return "unexpected token \(at)"

        case .failedParsingNumberLiteral:
            return "failed parsing number literal \(at)"

        case .unterminatedString:
            return "unterminated string \(at)"
        }
    }

    private var at: String {
        return "at line \(location)"
    }
}
