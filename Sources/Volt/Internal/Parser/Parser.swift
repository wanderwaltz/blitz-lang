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
        if match(.import) {
            return try parseImportStatement()
        }

        if match(.func) {
            return try parseFunctionDeclaration(kind: "function")
        }

        if match(.var, .let) {
            return try parseVarDeclaration()
        }

        return try parseStatement()
    }

    private func parseImportStatement() throws -> Statement {
        let name = try consume(.identifier, "expected module name")
        return ImportStatement(identifier: name)
    }

    private func parseFunctionDeclaration(kind: String) throws -> Statement {
        let name = try consume(.identifier, "expected \(kind) name")

        try consume(.leftParen, "expecred ( after \(kind) name")

        var parameters: [Token] = []

        if !check(.rightParen) {
            repeat {
                parameters.append(try consume(.identifier, "expected parameter name"))
            } while match(.comma)
        }

        try consume(.rightParen, "expected ) after \(kind) parameter list")
        try consume(.leftBrace, "expected { before \(kind) body")

        let body = try parseBlockStatement()

        return FunctionDeclarationStatement(
            name: name,
            parameters: parameters,
            body: body
        )
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
        if match(.break, .continue) {
            return SingleKeywordStatement(keyword: previous())
        }

        if match(.if) {
            return try parseIfStatement()
        }

        if match(.print) {
            return try parsePrintStatement()
        }

        if match(.return) {
            return try parseReturnStatement()
        }

        if match(.while) {
            return try parseWhileStatement()
        }

        if match(.for) {
            return try parseForStatement()
        }

        if match(.leftBrace) {
            return try parseBlockStatement()
        }

        return try parseExpressionStatement()
    }

    private func parseIfStatement() throws -> Statement {
        let condition = try parseExpression()
        try consume(.leftBrace, "expected { after if condition")
        let thenStatement = try parseBlockStatement()
        var elseStatement: Statement?

        if match(.else) {
            if match(.if) {
                elseStatement = try parseIfStatement()
            }
            else {
                try consume(.leftBrace, "expected { or if after else")
                elseStatement = try parseBlockStatement()
            }
        }

        return IfStatement(condition: condition, thenStatement: thenStatement, elseStatement: elseStatement)
    }

    private func parsePrintStatement() throws -> Statement {
        let keyword = previous()
        let expression = try parseExpression()
        return PrintStatement(keyword: keyword, expression: expression)
    }

    private func parseWhileStatement() throws -> Statement {
        let condition = try parseExpression()
        try consume(.leftBrace, "expected { after while")
        let body = try parseBlockStatement()
        return WhileStatement(condition: condition, body: body)
    }

    private func parseForStatement() throws -> Statement {
        // `for` loop is transformed into `while` loop during parsing
        // so that we don't need another statement class for it
        try consume(.leftParen, "expected ( after for")

        var initializer: Statement?

        if check(.semicolon) {
            // no initializer
        }
        else if match(.var) {
            initializer = try parseVarDeclaration()
        }
        else {
            initializer = try parseExpressionStatement()
        }

        try consume(.semicolon, "expected ; after loop initializer")

        var condition: Expression?

        if !check(.semicolon) {
            condition = try parseExpression()
        }

        try consume(.semicolon, "expected ; after loop condition")

        var increment: Expression?

        if !check(.rightParen) {
            increment = try parseExpression()
        }

        try consume(.rightParen, "expected ) after for clauses")
        try consume(.leftBrace, "expected { after for clauses")

        var body: Statement = try parseBlockStatement()

        if let increment = increment {
            body = BlockStatement(
                statements: [
                    body
                ],
                atExit: [
                    ExpressionStatement(expression: increment)
                ]
            )
        }

        body = WhileStatement(
            condition: condition ?? LiteralExpression(literal: .true),
            body: body
        )

        if let initializer = initializer {
            body = BlockStatement(
                statements: [
                    initializer,
                    body
                ]
            )
        }

        return body
    }

    private func parseBlockStatement() throws -> BlockStatement {
        var statements: [Statement] = []
        var atExit: [Statement] = []

        while !check(.rightBrace) && !isAtEnd {
            // parse deferred statements for block
            if match(.defer) {
                try consume(.leftBrace, "expected { after defer")
                var deferredStatements: [Statement] = []

                while !check(.rightBrace) && !isAtEnd {
                    deferredStatements.append(try parseDeclaration())
                }

                try consume(.rightBrace, "expected } after defer")

                atExit = deferredStatements + atExit
                continue
            }

            statements.append(try parseDeclaration())
        }

        try consume(.rightBrace, "expected } after block")
        return BlockStatement(statements: statements, atExit: atExit)
    }

    private func parseExpressionStatement() throws -> ExpressionStatement {
        let expression = try parseExpression()
        return ExpressionStatement(expression: expression)
    }

    private func parseReturnStatement() throws -> Statement {
        let keyword = previous()
        var value: Expression = LiteralExpression(literal: .nil)

        if !check(.rightBrace) {
            value = try parseExpression()
        }

        return ReturnStatement(
            keyword: keyword,
            value: value
        )
    }

    private func parseExpression() throws -> Expression {
        return try parseAssignment()
    }

    private func parseAssignment() throws -> Expression {
        let expression = try parseOr()

        if match(.equal, .minusEqual, .plusEqual, .slashEqual, .starEqual) {
            let op = previous()
            let value = try parseAssignment()

            if let variableExpression = expression as? VariableExpression {
                let name = variableExpression.identifier
                return AssignmentExpression(identifier: name, op: op, value: value)
            }

            throw error("invalid assignment")
        }

        return expression
    }

    private func parseOr() throws -> Expression {
        var expr = try parseAnd()

        while match(.or) {
            let op = previous()
            let right = try parseAnd()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseAnd() throws -> Expression {
        var expr = try parseEquality()

        while match(.and) {
            let op = previous()
            let right = try parseEquality()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
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
        var expr = try parseQuestionQuestionOperator()

        while match(.slash, .star) {
            let op = previous()
            let right = try parseQuestionQuestionOperator()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseQuestionQuestionOperator() throws -> Expression {
        var expr = try parseUnary()

        while match(.questionQuestion) {
            let op = previous()
            let right = try parseUnary()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseUnary() throws -> Expression {
        if match(.bang, .minus, .not) {
            let op = previous()
            let expr = try parseUnary()
            return UnaryExpression(op: op, expression: expr)
        }

        return try parseCall()
    }

    private func parseCall() throws -> Expression {
        var expr = try parsePrimary()

        while true {
            if match(.leftParen) {
                expr = try parseCallCompletion(expr)
            }
            else {
                break
            }
        }

        return expr
    }

    private func parseCallCompletion(_ callee: Expression) throws -> Expression {
        var arguments: [Expression] = []

        if !check(.rightParen) {
            repeat {
                arguments.append(try parseExpression())
            } while match(.comma)
        }

        let paren = try consume(.rightParen, "expected ) after call arguments")

        return CallExpression(
            callee: callee,
            paren: paren,
            arguments: arguments
        )
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
        return ParserError(code: .syntaxError, message: message, location: tokens[currentIndex].location)
    }

    private var isAtEnd: Bool {
        return currentIndex >= tokens.count
    }

    private let tokens: [Token]
    private var currentIndex = 0
}
