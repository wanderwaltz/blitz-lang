extension TokenType: CustomStringConvertible {
    var description: String {
        switch self {
        // literals
        case .number: return "$num"

        // operators
        case .plus: return "+"
        case .minus: return "-"
        case .star: return "*"
        case .slash: return "/"
        }
    }
}
