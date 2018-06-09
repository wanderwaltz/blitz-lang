extension Method where _InstanceType == Instance {
    init(_ function: Function) {
        self.init(
            validBoundCallSignatures: function.validCallSignatures,
            bind: { instance in
                let environment = InterpreterEnvironment(parent: function.closure)

                environment.forceDefineVariable(
                    named: .self(at: function.declaration.location),
                    value: .object(instance),
                    isMutable: false
                )

                return Function(
                    declaration: function.declaration,
                    closure: environment
                )
            }
        )
    }
}
