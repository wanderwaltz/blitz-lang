struct Parser {
    func parse(_ tokens: [Token]) throws -> [Statement] {
        return try ParserImpl(tokens).parse()
    }
}

private final class ParserImpl {
    init(_ tokens: [Token]) {
        self.tokens = tokens
    }

    func parse() throws -> [Statement] {
        var statements: [Statement] = []

        while !isAtEnd {
            statements.append(try parseDeclaration())
        }

        return statements
    }

    private func parseDeclaration() throws -> Statement {
        if match(.var, .let) {
            return try parseVarDeclaration()
        }

        return try parseStatement()
    }

    private func parseVarDeclaration() throws -> Statement {
        let keyword = previous()
        let name = try consume(.identifier, "expected an identifier")
        var initializer: Expression = LiteralExpression.nil

        if match(.equal) {
            initializer = try parseExpression()
        }

        return VariableDeclarationStatement(keyword: keyword, identifier: name, initializer: initializer)
    }

    private func parseStatement() throws -> Statement {
        if match(.print) {
            return try parsePrintStatement()
        }

        if match(.leftBrace) {
            return try parseBlockStatement()
        }

        return try parseExpressionStatement()
    }

    private func parsePrintStatement() throws -> Statement {
        let expression = try parseExpression()
        return PrintStatement(expression: expression)
    }

    private func parseBlockStatement() throws -> Statement {
        var statements: [Statement] = []

        while !check(.rightBrace) && !isAtEnd {
            statements.append(try parseDeclaration())
        }

        try consume(.rightBrace, "expected }")
        return BlockStatement(statements: statements)
    }

    private func parseExpressionStatement() throws -> ExpressionStatement {
        let expression = try parseExpression()
        return ExpressionStatement(expression: expression)
    }

    private func parseExpression() throws -> Expression {
        return try parseAssignment()
    }

    private func parseAssignment() throws -> Expression {
        let expression = try parseEquality()

        if match(.equal) {
            let value = try parseAssignment()

            if let variableExpression = expression as? VariableExpression {
                let name = variableExpression.identifier
                return AssignmentExpression(identifier: name, value: value)
            }

            throw error("invalid assignment")
        }

        return expression
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

        if match(.identifier) {
            return VariableExpression(identifier: previous())
        }

        if match(.leftParen) {
            let expr = try parseExpression()
            try consume(.rightParen, "expected ')' after expression")
            return GroupingExpression(expression: expr)
        }

        throw error("expected expression")
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