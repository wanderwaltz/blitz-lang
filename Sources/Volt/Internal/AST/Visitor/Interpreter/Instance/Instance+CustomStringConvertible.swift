extension Instance: CustomStringConvertible {
    var description: String {
        return "\(klass.name)<\(ObjectIdentifier(self).voltDescription)>"
    }
}
