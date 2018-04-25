public final class VM {
    public init() {}

    public func run() {
        let source = """
            let x = 456
            {
                var x = 768
                {
                    let x = "qqq"
                    {
                        let q = x
                        print q
                    }
                }
                print x
            }
            print x
        """

        do {
            let tokens = try Scanner().process(source)
            let ast = try Parser().parse(tokens)
            let printer = ASTPrinter()
            let interpreter = ASTInterpreter()

            print(printer.print(ast))
            interpreter.execute(ast)
        }
        catch let error {
            print(error)
        }
    }
}
