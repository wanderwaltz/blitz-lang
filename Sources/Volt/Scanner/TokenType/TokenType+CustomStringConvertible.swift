extension TokenType: CustomStringConvertible {
    var description: String {
        switch self {
            // single-character tokens
        case .leftParen: return "("
        case .rightParen: return ")"
        case .leftBrace: return "{"
        case .rightBrace: return "}"
        case .comma: return ","
        case .dot: return "."
        case .minus: return "-"
        case .plus: return "+"
        case .slash: return "/"
        case .star: return "*"

        // one or two character tokens
        case .bang: return "!"
        case .bangEqual: return "!="
        case .equal: return "="
        case .equalEqual: return "=="
        case .greater: return ">"
        case .greaterEqual: return ">="
        case .less: return "<"
        case .lessEqual: return "<="

        // literals
        case .identifier: return "$id"
        case .string: return "$str"
        case .number: return "$num"

        // keywords
        case .and: return "and"
        case .`class`: return "class"
        case .`else`: return "else"
        case .`false`: return "false"
        case .`func`: return "func"
        case .`for`: return "for"
        case .`if`: return "if"
        case .`nil`: return "nil"
        case .`or`: return "or"
        case .`not`: return "not"
        case .`return`: return "return"
        case .`super`: return "super"
        case .`self`: return "self"
        case .`true`: return "true"
        case .`let`: return "let"
        case .`var`: return "var"
        case .`while`: return "while"

        case .eof: return "eof"
        }
    }
}
