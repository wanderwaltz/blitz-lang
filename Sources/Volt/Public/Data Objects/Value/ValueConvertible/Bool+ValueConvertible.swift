extension Bool: ValueConvertible {
    public var voltValue: Value {
        return .bool(self)
    }
}
