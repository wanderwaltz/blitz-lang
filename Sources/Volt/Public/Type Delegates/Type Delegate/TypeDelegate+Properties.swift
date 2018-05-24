extension TypeDelegate {
    @discardableResult
    public func registerProperty<T>(named name: String, keyPath: KeyPath<Object, T>) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                .init(object[keyPath: keyPath])
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMutableProperty<T>(named name: String, keyPath: ReferenceWritableKeyPath<Object, T>) -> Self {
        return registerProperty(
            named: name,
            getter: { object -> Value in
                .init(object[keyPath: keyPath])
            },
            setter: { object, value in
                try typecheck(value, T.self) { arg in
                    object[keyPath: keyPath] = arg
                }
            }
        )
    }

    @discardableResult
    public func registerPropertyAsMethod<T>(named name: String, keyPath: KeyPath<Object, T>) -> Self {
        return registerProperty(
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
}
