struct Scanner {
    func process(_ source: String) throws -> [Token] {
        guard !source.isEmpty else {
            return []
        }

        return try ScannerImpl(source).scan()
    }
}


private final class ScannerImpl {
    init(_ source: String) {
        self.source = source
        self.currentIndex = source.startIndex
        self.lineStart = source.startIndex
        self.tokenStart = source.startIndex
    }

    func scan() throws -> [Token] {
        scannedTokens = []
        currentIndex = source.startIndex
        lineNumber = 0

        while !isAtEnd {
            tokenStart = currentIndex
            try scanToken()
        }

        return scannedTokens
    }

    private func scanToken() throws {
        let character = advance()

        switch character {
        case "+": addToken(.plus)
        case "-": addToken(.minus)
        case "*": addToken(.star)
        case "/": addToken(.slash)

        case _ where character.isDigit:
            try scanNumber()

        case _ where character.isNewline:
            lineNumber += 1
            lineStart = currentIndex

        case _ where character.isWhitespace:
            break

        default:
            throw error(.unexpectedToken)
        }
    }

    private func scanNumber() throws {
        while peek().isDigit {
            advance()
        }

        // look for fractional part
        if peek() == "." && peekNext().isDigit {
            advance() // consume the "."

            while peek().isDigit {
                advance()
            }
        }

        guard let value = Number(currentLexeme()) else {
            throw error(.failedParsingNumberLiteral)
        }

        addNumberToken(value)
    }

    private func addToken(_ type: TokenType) {
        scannedTokens.append(.init(
            type: type,
            lexeme: currentLexeme()
        ))
    }

    private func addNumberToken(_ number: Number) {
        scannedTokens.append(.init(
            literal: number,
            lexeme: currentLexeme()
        ))
    }

    private func currentLexeme() -> String {
        return String(source[tokenStart..<currentIndex])
    }

    private func peek() -> Character {
        guard !isAtEnd else {
            return "\0".first!
        }

        return source[currentIndex]
    }

    private func peekNext() -> Character {
        guard case let nextIndex = source.index(after: currentIndex), nextIndex < source.endIndex else {
            return "\0".first!
        }

        return source[nextIndex]
    }

    @discardableResult
    private func advance() -> Character {
        defer {
            currentIndex = source.index(after: currentIndex)
        }

        return source[currentIndex]
    }

    private func error(_ code: ScannerError.Code) -> ScannerError {
        let position = source.distance(from: lineStart, to: tokenStart)
        return ScannerError(code: .unexpectedToken, line: lineNumber, position: position)
    }

    private var isAtEnd: Bool {
        return currentIndex == source.endIndex
    }

    private let source: String

    private var tokenStart: String.Index
    private var currentIndex: String.Index

    private var lineStart: String.Index
    private var lineNumber = 0

    private var scannedTokens: [Token] = []
}
