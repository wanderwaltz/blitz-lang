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
        // single-character tokens
        case "(": addToken(.leftParen)
        case ")": addToken(.rightParen)
        case "{": addToken(.leftBrace)
        case "}": addToken(.rightBrace)
        case ",": addToken(.comma)
        case ".": addToken(.dot)
        case "-": addToken(.minus)
        case "+": addToken(.plus)
        case "*": addToken(.star)

        // one or two character tokens
        case "!": addToken(match("=") ? .bangEqual : .bang)
        case "=": addToken(match("=") ? .equalEqual : .equal)
        case "<": addToken(match("=") ? .lessEqual : .less)
        case ">": addToken(match("=") ? .greaterEqual : .greater)

        // literals
        case "\"":
            try scanString()

        case _ where character.isDigit:
            try scanNumber()

        case _ where character.isPermittedForFirstIdentifierSymbol:
            scanIdentifierOrKeyword()

        // complex lexemes
        case "/":
            if match("/") {
                // a single-line comment goes until the end of the line.
                while (peek() != "\n" && !isAtEnd) {
                    advance()
                }
            }
            else {
                addToken(.slash)
            }

        // whitespace
        case _ where character.isNewline:
            markNewline()

        case _ where character.isWhitespace:
            break

        default:
            throw error(.unexpectedToken)
        }
    }

    private func scanString() throws {
        while peek() != "\"" && !isAtEnd {
            if peek().isNewline {
                markNewline()
            }

            advance()
        }

        // unterminated string
        if isAtEnd {
            throw error(.unterminatedString)
        }

        // the closing "
        advance()

        // trim the surrounding quotes.
        let value = String(currentLexeme().dropFirst().dropLast())

        addStringToken(value)
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

    private func scanIdentifierOrKeyword() {
        while peek().isPermittedForIdentifier {
            advance()
        }

        if let keyword = TokenType.keywords[currentLexeme()] {
            addToken(keyword)
        }
        else {
            addToken(.identifier)
        }
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

    private func addStringToken(_ string: String) {
        scannedTokens.append(.init(
            literal: string,
            lexeme: currentLexeme()
        ))
    }

    private func currentLexeme() -> String {
        return String(source[tokenStart..<currentIndex])
    }

    private func peek() -> Character {
        guard !isAtEnd else {
            return invalidCharacter
        }

        return source[currentIndex]
    }

    private func peekNext() -> Character {
        guard case let nextIndex = source.index(after: currentIndex), nextIndex < source.endIndex else {
            return invalidCharacter
        }

        return source[nextIndex]
    }

    private func match(_ expected: Character) -> Bool {
        guard !isAtEnd else {
            return false
        }

        guard peek() == expected else {
            return false
        }

        advance()
        return true
    }

    @discardableResult
    private func advance() -> Character {
        defer {
            currentIndex = source.index(after: currentIndex)
        }

        return source[currentIndex]
    }

    private func markNewline() {
        lineNumber += 1
        lineStart = currentIndex
    }

    private func error(_ code: ScannerError.Code) -> ScannerError {
        let position = source.distance(from: lineStart, to: tokenStart)
        return ScannerError(code: .unexpectedToken, line: lineNumber, position: position)
    }

    private var isAtEnd: Bool {
        return currentIndex == source.endIndex
    }

    private let source: String

    // used in peek() and peekNext() when peeking outside of the source
    private let invalidCharacter = "\0".first!

    private var tokenStart: String.Index
    private var currentIndex: String.Index

    private var lineStart: String.Index
    private var lineNumber = 0

    private var scannedTokens: [Token] = []
}
