struct Parser {
    func parse(_ tokens: [Token]) throws -> Expression {
        return try ParserImpl(tokens).parse()
    }
}

private final class ParserImpl {
    init(_ tokens: [Token]) {
        self.tokens = tokens
    }

    func parse() throws -> Expression {
        return try parseExpression()
    }

    private func parseExpression() throws -> Expression {
        return try parseEquality()
    }

    private func parseEquality() throws -> Expression {
        var expr = try parseComparison()

        while match(.bangEqual, .equalEqual) {
            let op = previous()
            let right = try parseComparison()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseComparison() throws -> Expression {
        var expr = try parseAddition()

        while match(.greater, .greaterEqual, .less, .lessEqual) {
            let op = previous()
            let right = try parseAddition()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseAddition() throws -> Expression {
        var expr = try parseMultiplication()

        while match(.minus, .plus) {
            let op = previous()
            let right = try parseMultiplication()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseMultiplication() throws -> Expression {
        var expr = try parseUnary()

        while match(.slash, .star) {
            let op = previous()
            let right = try parseUnary()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseUnary() throws -> Expression {
        if match(.bang, .minus, .not) {
            let op = previous()
            let expr = try parseUnary()
            return UnaryExpression(op: op, expression: expr)
        }

        return try parsePrimary()
    }

    private func parsePrimary() throws -> Expression {
        if match(.nil) {
            return LiteralExpression.nil
        }

        if match(.false) {
            return LiteralExpression.false
        }

        if match(.true) {
            return LiteralExpression.true
        }

        if match(.number, .string) {
            guard let literal = previous().literal else {
                preconditionFailure("expected a literal value")
            }

            return LiteralExpression(literal: literal)
        }

        if match(.leftParen) {
            let expr = try parseExpression()
            try consume(.rightParen, "Expected ')' after expression.")
            return GroupingExpression(expression: expr)
        }

        throw error("Expected expression.")
    }

    @discardableResult
    private func consume(_ type: TokenType, _ message: String) throws -> Token {
        if check(type) {
            return advance()
        }

        throw error(message);
    }

    private func match(_ types: TokenType...) -> Bool {
        for type in types {
            if check(type) {
                advance()
                return true
            }
        }

        return false
    }

    private func check(_ type: TokenType) -> Bool {
        guard !isAtEnd else {
            return false
        }

        return peek().type == type
    }

    private func peek() -> Token {
        guard !isAtEnd else {
            return .eof
        }

        return tokens[currentIndex]
    }

    private func previous() -> Token {
        return tokens[currentIndex-1]
    }

    @discardableResult
    private func advance() -> Token {
        if !isAtEnd {
            currentIndex += 1
        }

        return tokens[currentIndex-1]
    }

    private func error(_ message: String) -> ParserError {
        return ParserError(message: message)
    }

    private var isAtEnd: Bool {
        return currentIndex >= tokens.count
    }

    private let tokens: [Token]
    private var currentIndex = 0
}
