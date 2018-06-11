extension String: DefaultBindingsProviding {
    public static func registerDefaultBindings<Delegate: TypeDelegate>(using delegate: Delegate)
        where Delegate.Object == String {
            delegate
                .registerProperty(named: "isEmpty", keyPath: \.isEmpty)
                .registerProperty(named: "length", keyPath: \.count)

                .registerPropertyAsMethod(named: "capitalized", keyPath: \.capitalized)
                .registerMethod(selector: "lowercased()", method: String.lowercased)
                .registerMethod(selector: "uppercased()", method: String.uppercased)

                .registerMethod(selector: "hasPrefix(_:)", method: String.hasPrefix)
                .registerMethod(selector: "hasSuffix(_:)", method: String.hasSuffix)

                .registerMethod(selector: "trimmed()", method: { string in {
                    string.trimmingCharacters(in: .whitespacesAndNewlines)
                }})
    }
}
