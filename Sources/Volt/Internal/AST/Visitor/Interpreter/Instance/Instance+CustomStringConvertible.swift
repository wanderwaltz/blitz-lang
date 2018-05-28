extension Instance: CustomStringConvertible {
    var description: String {
        return "\(klass.name)<\(rawObjectIdentifier)>"
    }

    private var rawObjectIdentifier: String {
        return String(describing: ObjectIdentifier(self))
            .replacingOccurrences(of: "ObjectIdentifier(", with: "")
            .replacingOccurrences(of: ")", with: "")
    }
}
