extension FunctionDeclarationStatement {
    static func voidDoNothing(named name: Token, at location: SourceLocation) -> FunctionDeclarationStatement {
        return .init(
            name: name,
            parameters: [],
            body: .empty(at: location)
        )
    }
}
