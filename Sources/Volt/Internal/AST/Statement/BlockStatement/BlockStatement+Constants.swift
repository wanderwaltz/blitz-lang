extension BlockStatement {
    static func empty(at location: SourceLocation) -> BlockStatement {
        return BlockStatement(location: location, statements: [])
    }
}
