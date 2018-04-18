extension ScannerError: CustomStringConvertible {
    var description: String {
        switch code {
        case .unexpectedToken:
            return "unexpected token at line \(line):\(position)"

        case .failedParsingNumberLiteral:
            return "failed parsing number literal at line \(line):\(position)"
        }
    }
}
