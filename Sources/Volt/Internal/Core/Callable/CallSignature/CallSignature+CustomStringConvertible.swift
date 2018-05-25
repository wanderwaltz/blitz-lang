extension CallSignature: CustomStringConvertible {
    var description: String {
        guard !components.isEmpty else {
            return "()"
        }

        return components.joined(separator: ":") + ":"
    }
}
