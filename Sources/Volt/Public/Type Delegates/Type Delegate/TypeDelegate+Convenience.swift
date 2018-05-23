extension TypeDelegate {
    public func registerProperty<T>(named name: String, keyPath: KeyPath<Object, T>) {
        registerProperty(
            named: name,
            getter: { object in
                return .init(object[keyPath: keyPath])
            },
            setter: nil
        )
    }

    public func registerPropertyAsMethod<T>(named name: String, keyPath: KeyPath<Object, T>) {
        registerProperty(
            named: name,
            getter: { object in
                return .object(
                    AnyCallable({ _, _ in
                        .init(object[keyPath: keyPath])
                    })
                    .checkingArity(0)
                )
            },
            setter: nil
        )
    }

    public func registerMethod<R>(named name: String, method getter: @escaping (Object) -> () -> R) {
        registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _ in
                        .init(method())
                    })
                    .checkingArity(0)
                )
            },
            setter: nil
        )
    }

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
