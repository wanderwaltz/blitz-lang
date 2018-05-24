extension TypeDelegate {
    public func registerMethod<T, R>(named name: String, method getter: @escaping (Object) -> (T) -> R) {
        registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, args in
                        return try typecheck(args, T.self) {
                            Value(method($0))
                        }
                    })
                )
            },
            setter: nil
        )
    }
}
