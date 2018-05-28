extension CallSignature: CustomStringConvertible {
    var description: String {
        guard !components.isEmpty else {
            return "()"
        }

        return components.joined(separator: ":") + ":"
    }

    var selectorDescription: String {
        return "(\(components.isEmpty ? "" : description))"
    }
}
