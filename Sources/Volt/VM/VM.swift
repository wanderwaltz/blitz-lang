public final class VM {
    public init() {}

    public func run() {
        let left = LiteralExpression(literal: .number(123))
        let op = Token(type: .plus, lexeme: "+")
        let right = LiteralExpression(literal: .number(456))
        let binary = BinaryExpression(left: left, op: op, right: right)
        let printer = ASTPrinter()

        print(printer.print(binary))
    }
}
