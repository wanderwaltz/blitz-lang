extension TokenType {
    static let keywords: [String:TokenType] = {
        let keywordTokens: [TokenType] = [
            .and,
            .`class`,
            .`else`,
            .`false`,
            .`func`,
            .`for`,
            .`if`,
            .`nil`,
            .`or`,
            .`not`,
            .`return`,
            .`super`,
            .`self`,
            .`true`,
            .`let`,
            .`var`,
            .`while`,
        ]

        var result: [String:TokenType] = [:]

        for token in keywordTokens {
            result[token.description] = token
        }

        return result
    }()
}
