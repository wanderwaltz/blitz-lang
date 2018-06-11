extension ObjectIdentifier {
    var blitzDescription: String {
        return String(describing: self)
            .replacingOccurrences(of: "ObjectIdentifier(", with: "")
            .replacingOccurrences(of: ")", with: "")
    }
}
