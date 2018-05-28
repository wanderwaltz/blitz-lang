extension ObjectIdentifier {
    var voltDescription: String {
        return String(describing: self)
            .replacingOccurrences(of: "ObjectIdentifier(", with: "")
            .replacingOccurrences(of: ")", with: "")
    }
}
