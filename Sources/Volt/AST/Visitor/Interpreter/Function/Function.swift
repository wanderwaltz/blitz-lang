struct Function {
    let declaration: FunctionDeclarationStatement
}

extension Function {
    var arity: Int {
        return declaration.parameters.count
    }
}
