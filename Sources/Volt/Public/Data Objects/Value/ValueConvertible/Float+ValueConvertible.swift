extension Float: ValueConvertible {
    public var voltValue: Value {
        return .number(Number(self))
    }
}
