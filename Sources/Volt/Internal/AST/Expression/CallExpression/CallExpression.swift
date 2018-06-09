struct CallExpression: Expression {
    typealias Argument = (label: Token?, value: Expression)

    enum Kind {
    case call
    case `subscript`
    }

    let callee: Expression
    let leftParen: Token
    let arguments: [Argument]
    let rightParen: Token

    var location: SourceLocation {
        return leftParen.location
    }

    var kind: Kind {
        switch leftParen.type {
        case .leftParen: return .call
        case .leftBracket: return .subscript
        default:
            preconditionFailure("unexpected call expression: \(self)")
        }
    }

    func accept<Visitor: ASTVisitor>(_ visitor: Visitor) -> Visitor.ReturnValue {
        return visitor.visitCallExpression(self)
    }
}


extension CallExpression.Kind: CustomStringConvertible {
    var description: String {
        switch self {
        case .call: return "call"
        case .subscript: return "subscript"
        }
    }
}
