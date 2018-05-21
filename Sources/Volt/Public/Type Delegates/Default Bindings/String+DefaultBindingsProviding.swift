extension String: DefaultBindingsProviding {
    public static func registerDefaultBindings<Delegate: TypeDelegate>(using delegate: Delegate)
        where Delegate.Object == String {
            delegate.registerProperty(named: "isEmpty", keyPath: \.isEmpty)
            delegate.registerProperty(named: "length", keyPath: \.count)



            delegate.registerPropertyAsMethod(named: "capitalized", keyPath: \.capitalized)
            delegate.registerMethod(named: "lowercased", method: String.lowercased)
            delegate.registerMethod(named: "uppercased", method: String.uppercased)



            delegate.registerMethod(named: "hasPrefix", method: String.hasPrefix)
            delegate.registerMethod(named: "hasSuffix", method: String.hasSuffix)


            delegate.registerMethod(named: "trimmed", method: { string in {
                string.trimmingCharacters(in: .whitespacesAndNewlines)
            }})
    }
}
