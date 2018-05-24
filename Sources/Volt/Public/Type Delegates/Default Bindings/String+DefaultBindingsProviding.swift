extension String: DefaultBindingsProviding {
    public static func registerDefaultBindings<Delegate: TypeDelegate>(using delegate: Delegate)
        where Delegate.Object == String {
            delegate
                .registerProperty(named: "isEmpty", keyPath: \.isEmpty)
                .registerProperty(named: "length", keyPath: \.count)

                .registerPropertyAsMethod(named: "capitalized", keyPath: \.capitalized)
                .registerMethod(named: "lowercased", method: String.lowercased)
                .registerMethod(named: "uppercased", method: String.uppercased)

                .registerMethod(named: "hasPrefix", method: String.hasPrefix)
                .registerMethod(named: "hasSuffix", method: String.hasSuffix)

                .registerMethod(named: "trimmed", method: { string in {
                    string.trimmingCharacters(in: .whitespacesAndNewlines)
                }})
    }
}
