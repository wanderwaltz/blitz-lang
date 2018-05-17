struct Function {
    let declaration: FunctionDeclarationStatement
    let closure: ASTInterpreterEnvironment
}

extension Function {
    var arity: Int {
        return declaration.parameters.count
    }
}
