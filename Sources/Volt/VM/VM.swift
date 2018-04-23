public final class VM {
    public init() {}

    public func run() {
        let source = """
            (1 + 2) * 3 / 4 - 123 - 456
        """

        do {
            let tokens = try Scanner().process(source)
            let ast = try Parser().parse(tokens)
            let printer = ASTPrinter()

            print(printer.print(ast))
        }
        catch let error {
            print(error)
        }
    }
}
