struct Parser {
    func parse(_ tokens: TokenStream) throws -> [Statement] {
        return try ParserImpl(tokens).parse()
    }
}

private final class ParserImpl {
    init(_ tokens: TokenStream) {
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
        if try match(.import) {
            return try parseImportStatement()
        }

        if try match(.func) {
            return try parseFunctionDeclaration(kind: "function")
        }

        if try match(.var, .let) {
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
            } while try match(.comma)
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

        if try match(.equal) {
            initializer = try parseExpression()
        }

        return VariableDeclarationStatement(keyword: keyword, identifier: name, initializer: initializer)
    }

    private func parseStatement() throws -> Statement {
        if try match(.break, .continue) {
            return SingleKeywordStatement(keyword: previous())
        }

        if try match(.if) {
            return try parseIfStatement()
        }

        if try match(.print) {
            return try parsePrintStatement()
        }

        if try match(.return) {
            return try parseReturnStatement()
        }

        if try match(.while) {
            return try parseWhileStatement()
        }

        if try match(.for) {
            return try parseForStatement()
        }

        if try match(.leftBrace) {
            return try parseBlockStatement()
        }

        return try parseExpressionStatement()
    }

    private func parseIfStatement() throws -> Statement {
        let condition = try parseExpression()
        try consume(.leftBrace, "expected { after if condition")
        let thenStatement = try parseBlockStatement()
        var elseStatement: Statement?

        if try match(.else) {
            if try match(.if) {
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
        else if try match(.var) {
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
            if try match(.defer) {
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

        if try match(.equal, .minusEqual, .plusEqual, .slashEqual, .starEqual) {
            let op = previous()
            let value = try parseAssignment()

            if let variableExpression = expression as? VariableExpression {
                let name = variableExpression.identifier
                return AssignmentExpression(identifier: name, op: op, value: value)
            }
            else if let getExpression = expression as? GetExpression {
                let object = getExpression.object
                let name = getExpression.name
                return SetExpression(object: object, name: name, op: op, value: value)
            }

            throw error("invalid assignment")
        }

        return expression
    }

    private func parseOr() throws -> Expression {
        var expr = try parseAnd()

        while try match(.or) {
            let op = previous()
            let right = try parseAnd()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseAnd() throws -> Expression {
        var expr = try parseEquality()

        while try match(.and) {
            let op = previous()
            let right = try parseEquality()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseEquality() throws -> Expression {
        var expr = try parseComparison()

        while try match(.bangEqual, .equalEqual) {
            let op = previous()
            let right = try parseComparison()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseComparison() throws -> Expression {
        var expr = try parseAddition()

        while try match(.greater, .greaterEqual, .less, .lessEqual) {
            let op = previous()
            let right = try parseAddition()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseAddition() throws -> Expression {
        var expr = try parseMultiplication()

        while try match(.minus, .plus) {
            let op = previous()
            let right = try parseMultiplication()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseMultiplication() throws -> Expression {
        var expr = try parseQuestionQuestionOperator()

        while try match(.slash, .star) {
            let op = previous()
            let right = try parseQuestionQuestionOperator()
            expr = BinaryExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseQuestionQuestionOperator() throws -> Expression {
        var expr = try parseUnary()

        while try match(.questionQuestion) {
            let op = previous()
            let right = try parseUnary()
            expr = LogicalExpression(left: expr, op: op, right: right)
        }

        return expr
    }

    private func parseUnary() throws -> Expression {
        if try match(.bang, .minus, .not) {
            let op = previous()
            let expr = try parseUnary()
            return UnaryExpression(op: op, expression: expr)
        }

        return try parseCall()
    }

    private func parseCall() throws -> Expression {
        var expr = try parsePrimary()

        while true {
            if try match(.leftParen) {
                expr = try parseCallCompletion(expr)
            }
            else if try match(.dot) {
                let name = try consume(.identifier, "expected property name after '.'")
                expr = GetExpression(object: expr, name: name)
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
            } while try match(.comma)
        }

        let paren = try consume(.rightParen, "expected ) after call arguments")

        return CallExpression(
            callee: callee,
            paren: paren,
            arguments: arguments
        )
    }

    private func parsePrimary() throws -> Expression {
        if try match(.nil) {
            return LiteralExpression.nil
        }

        if try match(.false) {
            return LiteralExpression.false
        }

        if try match(.true) {
            return LiteralExpression.true
        }

        if try match(.number, .string) {
            guard let literal = previous().literal else {
                preconditionFailure("expected a literal value")
            }

            return LiteralExpression(literal: literal)
        }

        if try match(.identifier) {
            return VariableExpression(identifier: previous())
        }

        if try match(.leftParen) {
            let expr = try parseExpression()
            try consume(.rightParen, "expected ')' after expression")
            return GroupingExpression(expression: expr)
        }

        throw error("expected expression")
    }

    @discardableResult
    private func consume(_ type: TokenType, _ message: String) throws -> Token {
        if check(type) {
            return try advance()
        }

        throw error(message);
    }

    private func match(_ types: TokenType...) throws -> Bool {
        for type in types {
            if check(type) {
                try advance()
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
        return tokens.peek()
    }

    private func previous() -> Token {
        return tokens.previous()
    }

    @discardableResult
    private func advance() throws -> Token {
        return try tokens.advance()
    }

    private func error(_ message: String) -> ParserError {
        return ParserError(code: .syntaxError, message: message, location: peek().location)
    }

    private var isAtEnd: Bool {
        return peek().type == .eof
    }

    private let tokens: TokenStream
}
