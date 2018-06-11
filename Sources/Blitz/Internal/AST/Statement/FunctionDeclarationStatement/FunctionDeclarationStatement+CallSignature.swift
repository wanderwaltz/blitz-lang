extension FunctionDeclarationStatement {
    var signature: CallSignature {
        return .init(components: parameters.map({ $0.label.lexeme }))
    }
}
