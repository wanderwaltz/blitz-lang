extension TokenType {
    static let keywords: [String:TokenType] = {
        let keywordTokens: [TokenType] = [
            .`and`,
            .`break`,
            .`class`,
            .`continue`,
            .`defer`,
            .`else`,
            .`false`,
            .`for`,
            .`func`,
            .`get`,
            .`if`,
            .`import`,
            .`initKeyword`,
            .`let`,
            .`nil`,
            .`not`,
            .`or`,
            .`print`,
            .`return`,
            .`self`,
            .`set`,
            .`super`,
            .`true`,
            .`var`,
            .`while`,
        ]

        var result: [String: TokenType] = [:]

        for token in keywordTokens {
            result[token.description] = token
        }

        return result
    }()
}
