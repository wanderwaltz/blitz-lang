extension String: DefaultBindingsProviding {
    public static func registerDefaultBindings<Delegate: BuiltinDelegate>(using delegate: Delegate)
        where Delegate.Object == String {
            delegate.registerProperty(named: "length", keyPath: \.count)
            delegate.registerProperty(named: "isEmpty", keyPath: \.isEmpty)

            delegate.registerMethod(named: "uppercased", method: String.uppercased)
            delegate.registerMethod(named: "lowercased", method: String.lowercased)

            delegate.registerMethod(named: "hasPrefix", method: String.hasPrefix)
            delegate.registerMethod(named: "hasSuffix", method: String.hasSuffix)
    }
}
