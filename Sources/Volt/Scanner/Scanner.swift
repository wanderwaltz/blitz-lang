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
    }

    func scan() throws -> [Token] {
        scannedTokens = []
        currentIndex = source.startIndex
        currentLineNumber = 0

        while !isAtEnd {
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
        case "\n": currentLineNumber += 1
        case _ where isWhitespace(character): break
        default:
            let position = source.distance(from: source.startIndex, to: currentIndex)
            // TODO: add line
            throw ScannerError(code: .unexpextedToken, line: 0, position: position)
        }
    }

    private func addToken(_ type: TokenType) {
        scannedTokens.append(.init(type: type))
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
    private var currentIndex: String.Index
    private var currentLineNumber = 0

    private var scannedTokens: [Token] = []
}
