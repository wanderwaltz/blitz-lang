extension String: ValueConvertible {
    public var voltValue: Value {
        return .string(self)
    }
}
