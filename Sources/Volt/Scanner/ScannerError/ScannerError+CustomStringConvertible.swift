extension ScannerError: CustomStringConvertible {
    var description: String {
        switch code {
        case .unexpextedToken:
            return "unexpected token at line \(line):\(position)"
        }
    }
}
