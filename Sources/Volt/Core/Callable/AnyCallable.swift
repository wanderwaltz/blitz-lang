struct AnyCallable {
    init(_ call: @escaping ([Value]) throws -> Value) {
        _call = call
    }

    private let _call: ([Value]) throws -> Value
}


extension AnyCallable: Callable {
    func call(arguments: [Value]) throws -> Value {
        return try _call(arguments)
    }
}
