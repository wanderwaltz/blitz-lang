struct Scanner {
    func process(_ source: String) -> [Token] {
        return ScannerImpl(source).scan()
    }
}


private final class ScannerImpl {
    init(_ source: String) {
        self.source = source
        self.sourceLength = source.count
        self.currentIndex = source.startIndex
    }

    func scan() -> [Token] {
        scannedTokens = []
        currentIndex = source.startIndex

        while !isAtEnd {
            scanToken()
        }

        return scannedTokens
    }

    private func scanToken() {
        switch advance() {
        case "+": addToken(.plus)
        case "-": addToken(.minus)
        case "*": addToken(.star)
        case "/": addToken(.slash)
        default:
            fatalError("Unexpected token at \(currentIndex)")
        }
    }

    private func addToken(_ type: TokenType) {
        scannedTokens.append(.init(type: type))
    }

    private func advance() -> Character {
        defer {
            currentIndex = source.index(after: currentIndex)
        }

        return source[currentIndex]
    }

    private var isAtEnd: Bool {
        return currentIndex == source.endIndex
    }

    private let source: String
    private let sourceLength: Int
    private var currentIndex: String.Index

    private var scannedTokens: [Token] = []
}
