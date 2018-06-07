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
            value: AnyCallable(signature: selector.signature, { _, _, args in
                .string(String(describing: args[0].typeName))
            })
        )
    }
}
