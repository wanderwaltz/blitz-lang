extension CallExpression {
    var signature: CallSignature {
        return .init(components: arguments.map({ $0.label?.lexeme }))
    }
}
