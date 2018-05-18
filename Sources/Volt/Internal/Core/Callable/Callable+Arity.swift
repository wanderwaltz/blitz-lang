extension Callable {
    func checkingArity(_ arity: Int) -> AnyCallable {
        return AnyCallable({ interpeter, args in
            guard args.count == arity else {
                throw InternalError.invalidNumberOfArguments(expected: arity, got: args.count)
            }

            return try self.call(interpreter: interpeter, arguments: args)
        })
    }
}
