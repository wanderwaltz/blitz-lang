struct ScannerError: Error {
    enum Code: Int {
    case unexpectedToken = 1
    case failedParsingNumberLiteral = 2
    case unterminatedString = 3
    }

    let code: Code
    let location: SourceLocation
}
