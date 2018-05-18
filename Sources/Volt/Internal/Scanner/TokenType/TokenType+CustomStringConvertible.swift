extension TokenType: CustomStringConvertible {
    var description: String {
        switch self {
        // single-character tokens
        case .comma: return ","
        case .dot: return "."
        case .leftBrace: return "{"
        case .leftParen: return "("
        case .rightBrace: return "}"
        case .rightParen: return ")"
        case .semicolon: return ";"

        // one or two character tokens
        case .bang: return "!"
        case .bangEqual: return "!="
        case .equal: return "="
        case .equalEqual: return "=="
        case .greater: return ">"
        case .greaterEqual: return ">="
        case .less: return "<"
        case .lessEqual: return "<="
        case .minus: return "-"
        case .minusEqual: return "-="
        case .plus: return "+"
        case .plusEqual: return "+="
        case .questionQuestion: return "??"
        case .slash: return "/"
        case .slashEqual: return "/="
        case .star: return "*"
        case .starEqual: return "*="

        // literals
        case .identifier: return "$id"
        case .number: return "$num"
        case .string: return "$str"

        // keywords
        case .`and`: return "and"
        case .`break`: return "break"
        case .`class`: return "class"
        case .`continue`: return "continue"
        case .`defer`: return "defer"
        case .`else`: return "else"
        case .`false`: return "false"
        case .`for`: return "for"
        case .`func`: return "func"
        case .`if`: return "if"
        case .`import`: return "import"
        case .`let`: return "let"
        case .`nil`: return "nil"
        case .`not`: return "not"
        case .`or`: return "or"
        case .`print`: return "print"
        case .`return`: return "return"
        case .`self`: return "self"
        case .`super`: return "super"
        case .`true`: return "true"
        case .`var`: return "var"
        case .`while`: return "while"

        case .eof: return "eof"
        }
    }
}
