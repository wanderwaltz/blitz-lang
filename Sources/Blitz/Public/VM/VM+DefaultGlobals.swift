extension VM {
    func registerDefaultGlobals() {
        registerTypeOf()
    }

    private func registerTypeOf() {
        guard let selector = Selector(rawValue: "type(of:)") else {
            return
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable(signature: selector.signature, { parameters in
                .string(String(describing: parameters.arguments[0].typeName))
            })
        )
    }
}
