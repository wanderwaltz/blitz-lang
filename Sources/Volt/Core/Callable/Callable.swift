protocol Callable {
    func call(arguments: [Value]) throws -> Value
}
