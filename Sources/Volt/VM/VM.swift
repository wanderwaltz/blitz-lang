public final class VM {
    public init() {}

    public func run() {
        let source = """
            var x = 1
            let y = true
        """

        do {
            let tokens = try Scanner().process(source)
            let ast = try Parser().parse(tokens)
            let printer = ASTPrinter()
            let interpreter = ASTInterpreter()

            print(printer.print(ast))
            print(interpreter.execute(ast))
        }
        catch let error {
            print(error)
        }
    }
}
