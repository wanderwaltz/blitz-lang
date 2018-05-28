extension FunctionDeclarationStatement {
    static func voidDoNothing(named name: Token) -> FunctionDeclarationStatement {
        return .init(
            name: name,
            parameters: [],
            body: .empty
        )
    }
}
