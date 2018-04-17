import Foundation

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
        case "\n":
            lineNumber += 1
            lineStart = currentIndex

        case _ where isWhitespace(character): break
        default:
            let characterIndex = source.index(before: currentIndex)
            let position = source.distance(from: lineStart, to: characterIndex)
            throw ScannerError(code: .unexpectedToken, line: lineNumber, position: position)
        }
    }

    private func addToken(_ type: TokenType) {
        scannedTokens.append(.init(
            type: type,
            lexeme: String(source[tokenStart..<currentIndex])
        ))
    }

    private func peek() -> Character {
        return source[currentIndex]
    }

    @discardableResult
    private func advance() -> Character {
        defer {
            currentIndex = source.index(after: currentIndex)
        }

        return source[currentIndex]
    }

    private func isWhitespace(_ character: Character) -> Bool {
        for scalar in character.unicodeScalars {
            if whitespaceCharacters.contains(scalar) {
                return true
            }
        }

        return false
    }

    private var isAtEnd: Bool {
        return currentIndex == source.endIndex
    }

    private let whitespaceCharacters = CharacterSet.whitespaces
    private let source: String

    private var tokenStart: String.Index
    private var currentIndex: String.Index

    private var lineStart: String.Index
    private var lineNumber = 0

    private var scannedTokens: [Token] = []
}
