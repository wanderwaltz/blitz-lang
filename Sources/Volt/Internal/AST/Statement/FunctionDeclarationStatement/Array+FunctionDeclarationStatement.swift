extension Array where Element == FunctionDeclarationStatement.ParamDecl {
    static func singleParameterWithoutLabel(named name: Token) -> [Element] {
        return [
            (
                label: .labellessFuncPrameter(at: name.location),
                name: name
            )
        ]
    }
}
