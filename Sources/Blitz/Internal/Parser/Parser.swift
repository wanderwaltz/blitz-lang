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

        if try match(.class) {
            return try parseClassDeclaration()
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

    private func parseClassDeclaration() throws -> Statement {
        let name = try consume(.identifier, "expected class name")
        var superclass: VariableExpression?

        let initializerName = Token(
            type: .initKeyword,
            lexeme: String(describing: TokenType.initKeyword),
            location: name.location
        )

        if try match(.colon) {
            superclass = VariableExpression(
                identifier: try consume(.identifier, "expected superclass name")
            )
        }

        try consume(.leftBrace, "expected { before class body")

        var storedProperties: [String: VariableDeclarationStatement] = [:]
        var computedProperties: [String: ComputedPropertyDeclarationStatement] = [:]
        var methods: [FunctionDeclarationStatement] = []
        var initializers: [FunctionDeclarationStatement] = []

        func alreadyDefined(_ name: String) -> Bool {
            return storedProperties[name] != nil
                || computedProperties[name] != nil
        }

        while !check(.rightBrace) && !isAtEnd {
            if try match(.initKeyword) {
                initializers.append(
                    try parseFunctionDeclaration(
                        kind: "initializer",
                        named: initializerName
                    )
                )
            }
            else if try match(.var, .let) {
                let keyword = previous()
                let name = try consume(.identifier, "expected property name")
                let propertyName = name.lexeme

                guard !alreadyDefined(propertyName) else {
                    throw error("invalid redefenition of property '\(propertyName)'")
                }

                if try match(.leftBrace) {
                    guard keyword.type == .var else {
                        throw error("computed properties should be declared with var keyword")
                    }

                    var _getter: BlockStatement?
                    var setter: BlockStatement?

                    if try match(.get) {
                        try consume(.leftBrace, "expected { after get keyword")
                        _getter = try parseBlockStatement()

                        try consume(.set, "expected setter")
                        try consume(.leftBrace, "expected { after set keyword")
                        setter = try parseBlockStatement()
                        try consume(.rightBrace, "expected } after computed property accessors")
                    }
                    else {
                        _getter = try parseBlockStatement()
                    }

                    guard let getter = _getter else {
                        throw error("expected getter")
                    }

                    computedProperties[propertyName] = ComputedPropertyDeclarationStatement(
                        name: name,
                        getter: getter,
                        setter: setter
                    )
                }
                else {
                    storedProperties[propertyName] = try parseVarDeclaration(
                        keyword: keyword,
                        name: name
                    )
                }
            }
            else {
                try consume(.func, "expected method")
                let method = try parseFunctionDeclaration(kind: "method")
                methods.append(method)
            }
        }

        try consume(.rightBrace, "expected } after class body")

        if initializers.isEmpty {
            initializers.append(
                .voidDoNothing(named: initializerName, at: name.location)
            )
        }

        return ClassDeclarationStatement(
            name: name,
            superclass: superclass,
            initializers: initializers,
            storedProperties: Array(storedProperties.values).sorted(by: { $0.identifier.lexeme < $1.identifier.lexeme }),
            computedProperties: Array(computedProperties.values).sorted(by: { $0.name.lexeme < $1.name.lexeme }),
            methods: methods.sorted(by: { $0.name.lexeme < $1.name.lexeme })
        )
    }

    private func parseFunctionDeclaration(kind: String, named _name: Token? = nil) throws -> FunctionDeclarationStatement {
        let name = try _name ?? consume(.identifier, "expected \(kind) name")

        try consume(.leftParen, "expecred ( after \(kind) name")

        var parameters: [FunctionDeclarationStatement.ParamDecl] = []

        if !check(.rightParen) {
            repeat {
                let label = try consume(.identifier, "expected parameter label")
                let name = try consume(.identifier, "expected parameter name")
                parameters.append((label: label, name: name))
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

    private func parseVarDeclaration(keyword _keyword: Token? = nil,
                                     name _name: Token? = nil) throws -> VariableDeclarationStatement {
        let keyword = _keyword ?? previous()
        let name = try _name ?? consume(.identifier, "expected an identifier")
        var initializer: Expression = LiteralExpression(literal: .nil, location: name.location)

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
        let location = previous().location
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

        return IfStatement(
            condition: condition,
            thenStatement: thenStatement,
            elseStatement: elseStatement,
            location: location
        )
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
                location: increment.location,
                statements: [
                    body
                ],
                atExit: [
                    ExpressionStatement(expression: increment)
                ]
            )
        }

        body = WhileStatement(
            condition: condition ?? LiteralExpression(literal: .true, location: body.location),
            body: body
        )

        if let initializer = initializer {
            body = BlockStatement(
                location: initializer.location,
                statements: [
                    initializer,
                    body
                ]
            )
        }

        return body
    }

    private func parseBlockStatement() throws -> BlockStatement {
        let location = previous().location
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
        return BlockStatement(
            location: location,
            statements: statements,
            atExit: atExit
        )
    }

    private func parseExpressionStatement() throws -> ExpressionStatement {
        let expression = try parseExpression()
        return ExpressionStatement(expression: expression)
    }

    private func parseReturnStatement() throws -> Statement {
        let keyword = previous()
        var value: Expression?

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
            else if let superExpression = expression as? SuperExpression {
                return SuperSetExpression(
                    keyword: superExpression.keyword,
                    name: superExpression.name,
                    op: op,
                    value: value
                )
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
            if try match(.leftParen, .leftBracket) {
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
        let leftParen = previous()

        var arguments: [CallExpression.Argument] = []

        if !check(.rightParen) {
            repeat {
                var label: Token? = nil

                if check(.identifier, .colon) {
                    label = try consume(.identifier, "expected argument label")
                    try consume(.colon, "expected : after argument label")
                }

                let value = try parseExpression()

                arguments.append((label: label, value: value))
            } while try match(.comma)
        }

        guard try match(.rightParen, .rightBracket) else {
            throw error("expected ) after call arguments")
        }

        let rightParen = previous()

        return CallExpression(
            callee: callee,
            leftParen: leftParen,
            arguments: arguments,
            rightParen: rightParen
        )
    }

    private func parsePrimary() throws -> Expression {
        if try match(.nil) {
            return LiteralExpression(literal: .nil, location: previous().location)
        }

        if try match(.false) {
            return LiteralExpression(literal: .false, location: previous().location)
        }

        if try match(.true) {
            return LiteralExpression(literal: .true, location: previous().location)
        }

        if try match(.number, .string) {
            guard let literal = previous().literal else {
                preconditionFailure("expected a literal value")
            }

            return LiteralExpression(literal: literal, location: previous().location)
        }

        if try match(.super) {
            let keyword = previous()
            try consume(.dot, "expected . after super")
            let name = try consume(.identifier, "expected property or method identifier after super")
            return SuperExpression(keyword: keyword, name: name)
        }

        if try match(.self) {
            return SelfExpression(keyword: previous())
        }

        if try match(.identifier) {
            return VariableExpression(identifier: previous())
        }

        if try match(.leftBracket) {
            return try parseArrayLiteral()
        }

        if try match(.leftParen) {
            let expr = try parseExpression()
            try consume(.rightParen, "expected ')' after expression")
            return GroupingExpression(expression: expr)
        }

        throw error("expected expression")
    }

    private func parseArrayLiteral() throws -> Expression {
        let location = previous().location
        var elements: [Expression] = []

        while true {
            if try match(.comma) {
                continue
            }
            else if try match(.rightBracket) {
                break
            }
            else {
                elements.append(try parseExpression())
            }
        }

        return ArrayLiteralExpression(location: location, elements: elements)
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

    private func check(_ t1: TokenType, _ t2: TokenType) -> Bool {
        guard !isAtEnd else {
            return false
        }

        return peek().type == t1 && peekNext().type == t2
    }

    private func peek() -> Token {
        return tokens.peek()
    }

    private func peekNext() -> Token {
        return tokens.peekNext()
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
