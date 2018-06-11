extension Program: CustomStringConvertible {
    public var description: String {
        return ASTPrinter().print(statements)
    }
}
