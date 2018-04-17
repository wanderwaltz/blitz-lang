struct ScannerError: Error {
    enum Code: Int {
    case unexpectedToken = 1
    }

    let code: Code
    let line: Int
    let position: Int
}
