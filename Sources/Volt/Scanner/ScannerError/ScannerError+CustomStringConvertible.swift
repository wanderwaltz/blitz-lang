extension ScannerError: CustomStringConvertible {
    var description: String {
        switch code {
        case .unexpectedToken:
            return "unexpected token at line \(line):\(position)"
        }
    }
}
