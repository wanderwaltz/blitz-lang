extension Token: Equatable {
    static func == (left: Token, right: Token) -> Bool {
        return left.type == right.type
    }
}
