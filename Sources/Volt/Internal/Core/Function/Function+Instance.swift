extension Function {
    func bind(to instance: Instance) -> Function {
        let environment = ASTInterpreterEnvironment(parent: closure)

        environment.forceDefineVariable(
            named: .self(at: declaration.name.location),
            value: .object(instance),
            isMutable: false
        )

        return Function(
            declaration: declaration,
            closure: environment
        )
    }
}
