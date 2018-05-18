func typecheck<T0, R>(_ args: [Value], _ type1: T0.Type, _ block: (T0) -> R) throws -> R {
    guard args.count == 1 else {
        throw InternalError.invalidNumberOfArguments(expected: 1, got: args.count)
    }

    guard let v0 = args[0].any as? T0 else {
        throw InternalError.typeError(expected: String(describing: T0.self), got: args[0].typeName)
    }

    return block(v0)
}
