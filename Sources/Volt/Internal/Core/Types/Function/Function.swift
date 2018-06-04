struct Function {
    let declaration: FunctionDeclarationStatement
    let closure: InterpreterEnvironment
}

extension Function {
    var arity: Int {
        return declaration.parameters.count
    }
}
