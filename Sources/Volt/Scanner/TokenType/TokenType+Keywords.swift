extension TokenType {
    static let keywords: [String:TokenType] = {
        let keywordTokens: [TokenType] = [
            .`and`,
            .`break`,
            .`class`,
            .`else`,
            .`false`,
            .`for`,
            .`func`,
            .`if`,
            .`import`,
            .`let`,
            .`nil`,
            .`not`,
            .`or`,
            .`print`,
            .`return`,
            .`self`,
            .`super`,
            .`true`,
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
